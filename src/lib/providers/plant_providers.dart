import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/models/enums.dart';
import '../domain/models/plant.dart';
import '../domain/models/daily_log.dart';
import 'database_provider.dart';

// ---------------------------------------------------------------------------
// Read-only stream / future providers
// ---------------------------------------------------------------------------

/// Streams all plants from the local database in real-time.
final plantsStreamProvider = StreamProvider<List<Plant>>((ref) {
  final repo = ref.watch(plantRepositoryProvider);
  return repo.watchAllPlants();
});

/// Fetches a single plant by id.
final plantByIdProvider =
    FutureProvider.family<Plant?, int>((ref, id) async {
  final repo = ref.watch(plantRepositoryProvider);
  return repo.getPlantById(id);
});

/// Streams daily logs for a specific plant in real-time.
final dailyLogsForPlantProvider =
    StreamProvider.family<List<DailyLog>, int>((ref, plantId) {
  final repo = ref.watch(plantRepositoryProvider);
  return repo.watchLogsForPlant(plantId);
});

// ---------------------------------------------------------------------------
// PlantFormState — manages Add/Edit form state
// ---------------------------------------------------------------------------

class PlantFormState {
  const PlantFormState({
    required this.name,
    required this.type,
    required this.plantingDate,
    required this.currentStage,
    required this.sunlightScore,
    required this.waterScore,
    required this.soilScore,
    required this.season,
    this.notes,
    this.isSaving = false,
  });

  final String name;
  final PlantType type;
  final DateTime plantingDate;
  final GrowthStage currentStage;
  final double sunlightScore;
  final double waterScore;
  final double soilScore;
  final Season season;
  final String? notes;
  final bool isSaving;

  factory PlantFormState.initial() => PlantFormState(
        name: '',
        type: PlantType.tomato,
        plantingDate: DateTime.now(),
        currentStage: GrowthStage.seedling,
        sunlightScore: 3,
        waterScore: 3,
        soilScore: 3,
        season: Season.fromDate(DateTime.now()),
      );

  PlantFormState copyWith({
    String? name,
    PlantType? type,
    DateTime? plantingDate,
    GrowthStage? currentStage,
    double? sunlightScore,
    double? waterScore,
    double? soilScore,
    Season? season,
    String? notes,
    bool? isSaving,
  }) {
    return PlantFormState(
      name: name ?? this.name,
      type: type ?? this.type,
      plantingDate: plantingDate ?? this.plantingDate,
      currentStage: currentStage ?? this.currentStage,
      sunlightScore: sunlightScore ?? this.sunlightScore,
      waterScore: waterScore ?? this.waterScore,
      soilScore: soilScore ?? this.soilScore,
      season: season ?? this.season,
      notes: notes ?? this.notes,
      isSaving: isSaving ?? this.isSaving,
    );
  }

  /// Convert form state to a [Plant] domain model ready to save.
  Plant toPlant() {
    return Plant(
      name: name.trim().isEmpty ? type.displayName : name.trim(),
      type: type,
      plantingDate: plantingDate,
      currentStage: currentStage,
      sunlightScore: sunlightScore,
      waterScore: waterScore,
      soilScore: soilScore,
      season: season,
      notes: notes?.trim().isEmpty ?? true ? null : notes,
    );
  }
}

// ---------------------------------------------------------------------------
// PlantFormNotifier
// ---------------------------------------------------------------------------

class PlantFormNotifier extends StateNotifier<PlantFormState> {
  PlantFormNotifier(this._ref) : super(PlantFormState.initial());

  final Ref _ref;

  void updateName(String v) => state = state.copyWith(name: v);
  void updateType(PlantType v) => state = state.copyWith(type: v);
  void updatePlantingDate(DateTime v) =>
      state = state.copyWith(plantingDate: v);
  void updateCurrentStage(GrowthStage v) =>
      state = state.copyWith(currentStage: v);
  void updateSunlight(double v) => state = state.copyWith(sunlightScore: v);
  void updateWater(double v) => state = state.copyWith(waterScore: v);
  void updateSoil(double v) => state = state.copyWith(soilScore: v);
  void updateSeason(Season v) => state = state.copyWith(season: v);
  void updateNotes(String? v) => state = state.copyWith(notes: v);

  /// Persist the form as a new plant. Resets state on success.
  Future<void> save() async {
    if (state.isSaving) return;
    state = state.copyWith(isSaving: true);
    try {
      final repo = _ref.read(plantRepositoryProvider);
      await repo.addPlant(state.toPlant());
      state = PlantFormState.initial();
    } catch (_) {
      state = state.copyWith(isSaving: false);
      rethrow;
    }
  }
}

final plantFormProvider =
    StateNotifierProvider<PlantFormNotifier, PlantFormState>(
  (ref) => PlantFormNotifier(ref),
);
