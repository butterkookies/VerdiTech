import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/models/daily_log.dart';
import 'database_provider.dart';

class DailyLogFormState {
  const DailyLogFormState({
    required this.date,
    required this.sunlightScore,
    required this.waterScore,
    required this.soilScore,
    this.note,
    this.isSaving = false,
  });

  final DateTime date;
  final double sunlightScore;
  final double waterScore;
  final double soilScore;
  final String? note;
  final bool isSaving;

  factory DailyLogFormState.initial() => DailyLogFormState(
        date: DateTime.now(),
        sunlightScore: 3,
        waterScore: 3,
        soilScore: 3,
      );

  DailyLogFormState copyWith({
    DateTime? date,
    double? sunlightScore,
    double? waterScore,
    double? soilScore,
    String? note,
    bool? isSaving,
  }) {
    return DailyLogFormState(
      date: date ?? this.date,
      sunlightScore: sunlightScore ?? this.sunlightScore,
      waterScore: waterScore ?? this.waterScore,
      soilScore: soilScore ?? this.soilScore,
      note: note ?? this.note,
      isSaving: isSaving ?? this.isSaving,
    );
  }

  DailyLog toDailyLog(int plantId) {
    return DailyLog(
      plantId: plantId,
      date: date,
      sunlightScore: sunlightScore,
      waterScore: waterScore,
      soilScore: soilScore,
      note: note?.trim().isEmpty ?? true ? null : note,
    );
  }
}

class DailyLogFormNotifier extends StateNotifier<DailyLogFormState> {
  DailyLogFormNotifier(this._ref) : super(DailyLogFormState.initial());

  final Ref _ref;

  void updateDate(DateTime v) => state = state.copyWith(date: v);
  void updateSunlight(double v) => state = state.copyWith(sunlightScore: v);
  void updateWater(double v) => state = state.copyWith(waterScore: v);
  void updateSoil(double v) => state = state.copyWith(soilScore: v);
  void updateNote(String? v) => state = state.copyWith(note: v);

  Future<void> save(int plantId) async {
    if (state.isSaving) return;
    state = state.copyWith(isSaving: true);
    try {
      final repo = _ref.read(plantRepositoryProvider);
      await repo.upsertLog(state.toDailyLog(plantId));
      state = DailyLogFormState.initial();
    } catch (_) {
      state = state.copyWith(isSaving: false);
      rethrow;
    }
  }
}

final dailyLogFormProvider =
    StateNotifierProvider<DailyLogFormNotifier, DailyLogFormState>(
  (ref) => DailyLogFormNotifier(ref),
);
