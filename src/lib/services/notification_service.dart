import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz_data;

import '../domain/models/enums.dart';
import '../domain/models/plant.dart';

// ---------------------------------------------------------------------------
// Notification channel IDs and names
// ---------------------------------------------------------------------------

class _Channels {
  static const harvest = AndroidNotificationChannel(
    'vt_harvest',
    'Harvest Alerts',
    description: 'Notifies you when a plant is ready to harvest.',
    importance: Importance.high,
  );

  static const care = AndroidNotificationChannel(
    'vt_care',
    'Care Reminders',
    description: 'Daily reminders to water or check on your plants.',
    importance: Importance.defaultImportance,
  );

  static const stage = AndroidNotificationChannel(
    'vt_stage',
    'Growth Milestones',
    description: 'Alerts you when a plant reaches a new growth stage.',
    importance: Importance.defaultImportance,
  );
}

// ---------------------------------------------------------------------------
// NotificationService — thin wrapper around FlutterLocalNotificationsPlugin
// ---------------------------------------------------------------------------

class NotificationService {
  NotificationService._();

  static final _plugin = FlutterLocalNotificationsPlugin();
  static bool _initialised = false;

  // ---------------------------------------------------------------------------
  // Initialise — call once from main() before runApp
  // ---------------------------------------------------------------------------

  static Future<void> init() async {
    if (_initialised) return;
    tz_data.initializeTimeZones();

    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidInit);

    await _plugin.initialize(settings: initSettings);

    // Create the notification channels on Android 8+
    final androidPlugin =
        _plugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    await androidPlugin?.createNotificationChannel(_Channels.harvest);
    await androidPlugin?.createNotificationChannel(_Channels.care);
    await androidPlugin?.createNotificationChannel(_Channels.stage);

    // Request permission (Android 13+)
    await androidPlugin?.requestNotificationsPermission();

    _initialised = true;
  }

  // ---------------------------------------------------------------------------
  // Scheduling helpers
  // ---------------------------------------------------------------------------

  /// Unique int ID derived from plant id + channel suffix so we never collide.
  static int _id(int plantId, String channelSuffix) =>
      Object.hash(plantId, channelSuffix) & 0x7fffffff;

  /// Schedule all notifications for a plant based on its starting stage.
  /// Days are offset relative to now (day 0 = today).
  static Future<void> scheduleForPlant(Plant plant) async {
    if (plant.id == null) return;
    await cancelForPlant(plant.id!);

    final now = DateTime.now();
    final id = plant.id!;
    final name = plant.name;
    final type = plant.type.displayName;

    // --- Care reminder: daily at 8 AM starting tomorrow ---
    await _scheduleDailyReminder(
      notifId: _id(id, 'care_daily'),
      title: 'Time to check on $name',
      body: 'Your $type may need water or sunlight today.',
      hour: 8,
      minute: 0,
      channelId: _Channels.care.id,
    );

    // --- Stage milestone notifications ---
    // We estimate days based on plant currentStage and typical durations.
    final stageDays = _estimateStageDaysFromNow(plant.currentStage);
    for (final entry in stageDays.entries) {
      if (entry.value <= 0) continue;
      final targetDate = now.add(Duration(days: entry.value));
      await _scheduleOnce(
        notifId: _id(id, 'stage_${entry.key.name}'),
        title: '$name reached ${entry.key.displayName}',
        body:
            'Your $type has entered a new growth phase. Check the app for care tips.',
        scheduledDate: targetDate,
        channelId: _Channels.stage.id,
      );
    }

    // --- Harvest notification ---
    final harvestDays = _estimateHarvestDays(plant.currentStage);
    if (harvestDays > 0) {
      final harvestDate = now.add(Duration(days: harvestDays));

      // Pre-harvest nudge — 2 days before
      final nudgeDate = now.add(Duration(days: harvestDays - 2));
      if (harvestDays > 2) {
        await _scheduleOnce(
          notifId: _id(id, 'harvest_nudge'),
          title: '$name is almost ready',
          body: 'Harvest expected in about 2 days. Keep conditions steady.',
          scheduledDate: nudgeDate,
          channelId: _Channels.harvest.id,
        );
      }

      // Harvest ready
      await _scheduleOnce(
        notifId: _id(id, 'harvest_ready'),
        title: '$name is ready to harvest',
        body:
            'Your $type has reached peak ripeness. Time to pick it.',
        scheduledDate: harvestDate,
        channelId: _Channels.harvest.id,
      );
    }
  }

  static Future<void> cancelForPlant(int plantId) async {
    final suffixes = [
      'care_daily',
      'stage_seedling',
      'stage_youngPlant',
      'stage_flowering',
      'stage_fruiting',
      'stage_harvestReady',
      'harvest_nudge',
      'harvest_ready',
    ];
    for (final s in suffixes) {
      await _plugin.cancel(id: _id(plantId, s));
    }
  }

  // ---------------------------------------------------------------------------
  // Low-level scheduling primitives
  // ---------------------------------------------------------------------------

  static Future<void> _scheduleOnce({
    required int notifId,
    required String title,
    required String body,
    required DateTime scheduledDate,
    required String channelId,
  }) async {
    final tzDate = tz.TZDateTime.from(scheduledDate, tz.local);
    final isHarvest = channelId == _Channels.harvest.id;
    final isStage = channelId == _Channels.stage.id;
    await _plugin.zonedSchedule(
      id: notifId,
      title: title,
      body: body,
      scheduledDate: tzDate,
      notificationDetails: NotificationDetails(
        android: AndroidNotificationDetails(
          channelId,
          isHarvest
              ? _Channels.harvest.name
              : isStage
                  ? _Channels.stage.name
                  : _Channels.care.name,
          importance: isHarvest ? Importance.high : Importance.defaultImportance,
          priority: isHarvest ? Priority.high : Priority.defaultPriority,
          icon: '@mipmap/ic_launcher',
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
    );
  }

  static Future<void> _scheduleDailyReminder({
    required int notifId,
    required String title,
    required String body,
    required int hour,
    required int minute,
    required String channelId,
  }) async {
    final now = tz.TZDateTime.now(tz.local);
    var scheduled =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }

    await _plugin.zonedSchedule(
      id: notifId,
      title: title,
      body: body,
      scheduledDate: scheduled,
      notificationDetails: NotificationDetails(
        android: AndroidNotificationDetails(
          channelId,
          _Channels.care.name,
          importance: Importance.defaultImportance,
          priority: Priority.defaultPriority,
          icon: '@mipmap/ic_launcher',
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  // ---------------------------------------------------------------------------
  // Stage & harvest duration estimates (days from now)
  // ---------------------------------------------------------------------------

  /// Returns a map of each upcoming stage -> estimated days from today.
  static Map<GrowthStage, int> _estimateStageDaysFromNow(
      GrowthStage currentStage) {
    // Typical days per stage for most plants supported.
    const stageDurations = {
      GrowthStage.seedling: 10,
      GrowthStage.youngPlant: 14,
      GrowthStage.flowering: 10,
      GrowthStage.fruiting: 14,
      GrowthStage.harvestReady: 5,
    };

    final stages = GrowthStage.values;
    final currentIdx = currentStage.stageIndex;
    int cumulative = 0;
    final result = <GrowthStage, int>{};

    for (final stage in stages) {
      if (stage.stageIndex <= currentIdx) continue;
      cumulative += stageDurations[stage] ?? 10;
      result[stage] = cumulative;
    }
    return result;
  }

  static int _estimateHarvestDays(GrowthStage currentStage) {
    const total = {
      GrowthStage.seedling: 53,
      GrowthStage.youngPlant: 43,
      GrowthStage.flowering: 29,
      GrowthStage.fruiting: 19,
      GrowthStage.harvestReady: 0,
    };
    return total[currentStage] ?? 0;
  }
}

// ---------------------------------------------------------------------------
// Riverpod provider
// ---------------------------------------------------------------------------

final notificationServiceProvider = Provider<NotificationService>(
  (_) => throw UnimplementedError('Call NotificationService.init() in main()'),
);
