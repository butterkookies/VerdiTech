import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/models/enums.dart';
import '../../../domain/models/plant.dart';
import '../../../providers/plant_providers.dart';
import '../../../providers/prediction_providers.dart';
import '../../daily_log/presentation/add_daily_log_dialog.dart';

import '../../../presentation/theme/verditech_theme.dart';
import '../../../presentation/widgets/glass_container.dart';
import '../../../presentation/widgets/stage_chip.dart';

// ---------------------------------------------------------------------------
// Timeline
// ---------------------------------------------------------------------------

enum NodeState { done, current, upcoming }

class TimelineItem extends StatelessWidget {
  final GrowthStage stage;
  final String dayLabel;
  final NodeState state;
  final bool isLast;
  final String description;

  const TimelineItem({
    super.key,
    required this.stage,
    required this.dayLabel,
    required this.state,
    this.isLast = false,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final s = VTTheme.of(context);
    final active = state != NodeState.upcoming;
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              _Node(stage: stage, state: state),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    color: active
                        ? stage.color.withOpacity(0.5)
                        : Colors.white.withOpacity(0.08),
                  ),
                ),
            ],
          ),
          const SizedBox(width: VTSpace.md),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: VTSpace.md),
              child: GlassContainer(
                tint: state == NodeState.current
                    ? stage.color.withOpacity(0.12)
                    : null,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        StageChip(stage: stage, compact: true),
                        Text(dayLabel,
                            style: TextStyle(
                                color: s.textMuted, fontSize: 12)),
                      ],
                    ),
                    const SizedBox(height: VTSpace.sm),
                    Text(
                      description,
                      style: TextStyle(
                          color: s.textPrimary,
                          fontSize: 13,
                          height: 1.4),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Node extends StatefulWidget {
  final GrowthStage stage;
  final NodeState state;
  const _Node({required this.stage, required this.state});

  @override
  State<_Node> createState() => _NodeState();
}

class _NodeState extends State<_Node> with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
      vsync: this, duration: const Duration(seconds: 2))
    ..repeat(reverse: true);

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isCurrent = widget.state == NodeState.current;
    final isDone = widget.state == NodeState.done;

    final core = Container(
      width: 34,
      height: 34,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: widget.state != NodeState.upcoming
            ? VTGradients.forStage(widget.stage)
            : null,
        color: widget.state == NodeState.upcoming
            ? VTTheme.of(context).surfaceHigh
            : null,
        border: Border.all(color: VTTheme.of(context).glassStroke),
      ),
      child: Icon(
        isDone ? Icons.check : widget.stage.icon,
        size: 16,
        color: widget.state == NodeState.upcoming
            ? VTTheme.of(context).textMuted
            : Colors.black87,
      ),
    );

    if (!isCurrent) return core;

    return AnimatedBuilder(
      animation: _c,
      builder: (_, child) => Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 34 + 18 * _c.value,
            height: 34 + 18 * _c.value,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: widget.stage.color.withOpacity(0.4 * (1 - _c.value)),
            ),
          ),
          child!,
        ],
      ),
      child: core,
    );
  }
}

// ---------------------------------------------------------------------------
// Plant Details Screen
// ---------------------------------------------------------------------------

class PlantDetailsScreen extends ConsumerWidget {
  final String id;
  const PlantDetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plantAsync = ref.watch(plantByIdProvider(int.parse(id)));

    return plantAsync.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: Center(child: Text('Failed to load plant: $e')),
      ),
      data: (plant) {
        if (plant == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Not Found')),
            body: const Center(child: Text('Plant not found.')),
          );
        }
        return _PlantDetailsContent(plant: plant, rawId: id);
      },
    );
  }
}

class _PlantDetailsContent extends ConsumerWidget {
  final Plant plant;
  final String rawId;

  const _PlantDetailsContent({required this.plant, required this.rawId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = VTTheme.of(context);
    final recommendations = ref.watch(recommendationsProvider(plant));
    final forecast = ref.watch(forecastProvider(plant));
    final logsAsync = ref.watch(dailyLogsForPlantProvider(plant.id!));
    final logs = logsAsync.valueOrNull ?? [];
    final latestLog = logs.isNotEmpty ? logs.first : null;

    final forecastNodes = GrowthStage.values.map((stage) {
      final isDone = stage.stageIndex < plant.currentStage.stageIndex;
      final isCurrent = stage == plant.currentStage;
      final state = isCurrent ? NodeState.current : isDone ? NodeState.done : NodeState.upcoming;
      final entry = forecast.firstWhere((p) => p.predictedStage == stage, orElse: () => forecast.last);
      
      String desc;
      switch (state) {
        case NodeState.current:
          desc = 'Happening now — conditions are optimal.';
          break;
        case NodeState.done:
          desc = 'Completed on schedule.';
          break;
        case NodeState.upcoming:
          desc = 'Predicted by the CA engine.';
          break;
      }
      
      return TimelineItem(
        stage: stage,
        dayLabel: isCurrent ? 'Day ${plant.daysPlanted} (Current)' : isDone ? 'Completed' : 'Day ~${entry.dayOffset}',
        state: state,
        description: desc,
        isLast: stage == GrowthStage.values.last,
      );
    }).toList();

    return Scaffold(
      backgroundColor: s.bg,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: s.verdantDeep,
        foregroundColor: Colors.white,
        onPressed: () => showDialog(
          context: context,
          builder: (context) => AddDailyLogDialog(plantId: plant.id!),
        ),
        icon: const Icon(Icons.add),
        label: const Text('Log Today'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            backgroundColor: s.bg,
            iconTheme: IconThemeData(color: s.textPrimary),
            actions: [
              IconButton(
                icon: const Icon(Icons.analytics),
                tooltip: 'CA Visualization',
                onPressed: () => context.go('/plant/$rawId/visualization'),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.fromLTRB(56, 0, 16, 16),
              title: Text(
                plant.name,
                style: TextStyle(
                    color: s.textPrimary, fontWeight: FontWeight.w800),
              ),
              background: Container(
                decoration:
                    BoxDecoration(gradient: VTGradients.heroFor(s.brightness)),
                child: Align(
                  alignment: Alignment.center,
                  child: Icon(plant.currentStage.icon,
                      size: 90, color: plant.currentStage.color),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Vital stats row.
                Row(
                  children: [
                    Expanded(
                      child: _Vital(
                        icon: Icons.water_drop_outlined,
                        label: 'Water',
                        value: latestLog != null ? '${latestLog.waterScore.toInt()}%' : '--',
                        color: VTColors.seedling,
                      ),
                    ),
                    const SizedBox(width: VTSpace.md),
                    Expanded(
                      child: _Vital(
                        icon: Icons.grass_outlined,
                        label: 'Soil',
                        value: latestLog != null ? '${latestLog.soilScore.toInt()}%' : '--',
                        color: VTColors.fruiting,
                      ),
                    ),
                    const SizedBox(width: VTSpace.md),
                    Expanded(
                      child: _Vital(
                        icon: Icons.wb_sunny_outlined,
                        label: 'Light',
                        value: latestLog != null ? '${latestLog.sunlightScore.toInt()}%' : '--',
                        color: VTColors.harvest,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: VTSpace.lg),
                Text(
                  'Live Growth Forecast',
                  style: TextStyle(
                    color: s.textPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: VTSpace.md),
                ...forecastNodes,
                const SizedBox(height: VTSpace.sm),
                Text(
                  'Recommendations',
                  style: TextStyle(
                    color: s.textPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: VTSpace.md),
                if (recommendations.isEmpty)
                  Card(
                    color: s.surfaceHigh,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          const Icon(Icons.check_circle, color: VTColors.verdantDeep),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'All conditions are optimal! Keep up the great work.',
                              style: TextStyle(color: s.textPrimary),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  ...recommendations.map(
                    (rec) => _Recommendation(
                      icon: _iconForCategory(rec.category),
                      title: rec.category,
                      body: rec.message,
                      color: _colorForCategory(rec.category),
                    ),
                  ),
                const SizedBox(height: 80),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  IconData _iconForCategory(String category) {
    switch (category.toLowerCase()) {
      case 'watering':
        return Icons.water_drop;
      case 'sunlight':
        return Icons.wb_sunny;
      case 'soil':
        return Icons.grass;
      default:
        return Icons.info_outline;
    }
  }

  Color _colorForCategory(String category) {
    switch (category.toLowerCase()) {
      case 'watering':
        return VTColors.seedling;
      case 'sunlight':
        return VTColors.harvest;
      case 'soil':
        return VTColors.fruiting;
      default:
        return VTColors.verdant;
    }
  }
}

// ---------------------------------------------------------------------------
// Sub-widgets
// ---------------------------------------------------------------------------

class _Vital extends StatelessWidget {
  final IconData icon;
  final String label, value;
  final Color color;
  const _Vital(
      {required this.icon,
      required this.label,
      required this.value,
      required this.color});

  @override
  Widget build(BuildContext context) {
    final s = VTTheme.of(context);
    return GlassContainer(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Column(
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(height: VTSpace.sm),
          Text(value,
              style: TextStyle(
                  color: s.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w800)),
          Text(label,
              style: TextStyle(color: s.textMuted, fontSize: 11)),
        ],
      ),
    );
  }
}

class _Recommendation extends StatelessWidget {
  final IconData icon;
  final String title, body;
  final Color color;
  const _Recommendation(
      {required this.icon,
      required this.title,
      required this.body,
      required this.color});

  @override
  Widget build(BuildContext context) {
    final s = VTTheme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: VTSpace.md),
      child: GlassContainer(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: VTSpace.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: TextStyle(
                          color: s.textPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.w700)),
                  const SizedBox(height: 4),
                  Text(body,
                      style: TextStyle(
                          color: s.textMuted,
                          fontSize: 12,
                          height: 1.4)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
