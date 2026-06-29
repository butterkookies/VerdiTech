import '../models/enums.dart';
import '../models/environment_profile.dart';
import '../models/day_prediction.dart';
import '../models/plant.dart';

/// 1D Cellular Automata prediction engine for plant growth.
///
/// Each "cell" is a day. The cell's state is the plant's [GrowthStage] on
/// that day. Transition rules are driven by the [EnvironmentProfile] and
/// a season modifier specific to each [PlantType].
class CaEngine {
  const CaEngine();

  // ---------------------------------------------------------------------------
  // Factor weights per plant (sunlight / water / soil). Must sum to 1.0.
  // Source: research.md §3.2
  // ---------------------------------------------------------------------------
  static const Map<PlantType, _Weights> _weights = {
    PlantType.tomato: _Weights(sun: 0.35, water: 0.40, soil: 0.25),
    PlantType.eggplant: _Weights(sun: 0.30, water: 0.35, soil: 0.35),
    PlantType.silingLabuyo: _Weights(sun: 0.40, water: 0.25, soil: 0.35),
  };

  // ---------------------------------------------------------------------------
  // Season modifiers per plant. Source: research.md §4.2
  // ---------------------------------------------------------------------------
  static const Map<PlantType, Map<Season, double>> _seasonModifiers = {
    PlantType.tomato: {
      Season.tagInit: 0.85,
      Season.tagUlan: 0.70,
      Season.malamig: 1.00,
    },
    PlantType.eggplant: {
      Season.tagInit: 0.90,
      Season.tagUlan: 0.80,
      Season.malamig: 0.95,
    },
    PlantType.silingLabuyo: {
      Season.tagInit: 0.95,
      Season.tagUlan: 0.85,
      Season.malamig: 0.90,
    },
  };

  // ---------------------------------------------------------------------------
  // Minimum days a plant must stay in each stage before progression.
  // Source: research.md §2.1–2.3  (using midpoint of documented ranges)
  // ---------------------------------------------------------------------------
  static const Map<PlantType, Map<GrowthStage, int>> _minStageDays = {
    PlantType.tomato: {
      GrowthStage.seedling: 14,
      GrowthStage.youngPlant: 21,
      GrowthStage.flowering: 14,
      GrowthStage.fruiting: 20,
      GrowthStage.harvestReady: 0,
    },
    PlantType.eggplant: {
      GrowthStage.seedling: 14,
      GrowthStage.youngPlant: 28,
      GrowthStage.flowering: 14,
      GrowthStage.fruiting: 14,
      GrowthStage.harvestReady: 0,
    },
    PlantType.silingLabuyo: {
      GrowthStage.seedling: 14,
      GrowthStage.youngPlant: 21,
      GrowthStage.flowering: 14,
      GrowthStage.fruiting: 21,
      GrowthStage.harvestReady: 0,
    },
  };

  // ---------------------------------------------------------------------------
  // Thresholds
  // ---------------------------------------------------------------------------

  /// Adjusted env score at or above which the plant progresses normally.
  static const double _progressThreshold = 0.70;

  /// Adjusted env score at or above which progression is possible but delayed.
  static const double _delayedThreshold = 0.40;

  // ---------------------------------------------------------------------------
  // Public API
  // ---------------------------------------------------------------------------

  /// Compute a normalised environmental score (0.0–1.0) for the given
  /// [profile] and [plantType].
  double computeEnvScore(PlantType plantType, EnvironmentProfile profile) {
    final w = _weights[plantType]!;
    final raw = (w.sun * profile.sunlight +
                 w.water * profile.water +
                 w.soil * profile.soil) /
        5.0; // normalise from [1,5] range to [0.2,1.0]

    final seasonMod = _seasonModifiers[plantType]![profile.season] ?? 1.0;
    return (raw * seasonMod).clamp(0.0, 1.0);
  }

  /// Run the 1D CA simulation forward for [forecastDays] days starting from
  /// [plant]'s current state, using [environment] as the daily condition.
  ///
  /// Returns a list of [DayPrediction]s ordered by day.
  List<DayPrediction> forecast({
    required Plant plant,
    required EnvironmentProfile environment,
    int forecastDays = 60,
  }) {
    final predictions = <DayPrediction>[];
    var currentStage = plant.currentStage;
    var daysInStage = 0;
    final baseDate = DateTime.now();
    final score = computeEnvScore(plant.type, environment);
    final health = HealthStatus.fromScore(score);

    for (var day = 0; day < forecastDays; day++) {
      final date = baseDate.add(Duration(days: day));
      predictions.add(DayPrediction(
        dayOffset: plant.daysPlanted + day,
        date: date,
        predictedStage: currentStage,
        healthStatus: health,
        environmentalScore: score,
      ));

      // Advance the CA for the next iteration
      final next = _transition(
        plantType: plant.type,
        currentStage: currentStage,
        daysInStage: daysInStage,
        adjustedScore: score,
      );
      if (next == currentStage) {
        daysInStage++;
      } else {
        currentStage = next;
        daysInStage = 0;
      }
    }

    return predictions;
  }

  /// Estimate how many days remain until harvest from the current state.
  int estimateDaysToHarvest({
    required Plant plant,
    required EnvironmentProfile environment,
  }) {
    final preds = forecast(
      plant: plant,
      environment: environment,
      forecastDays: 180,
    );
    final harvestDay = preds.indexWhere(
      (p) => p.predictedStage == GrowthStage.harvestReady,
    );
    return harvestDay == -1 ? 180 : harvestDay;
  }

  // ---------------------------------------------------------------------------
  // Private CA transition logic
  // ---------------------------------------------------------------------------

  GrowthStage _transition({
    required PlantType plantType,
    required GrowthStage currentStage,
    required int daysInStage,
    required double adjustedScore,
  }) {
    // Terminal state — no further transitions
    if (currentStage == GrowthStage.harvestReady) {
      return GrowthStage.harvestReady;
    }

    final minDays =
        _minStageDays[plantType]![currentStage] ?? 0;

    if (adjustedScore >= _progressThreshold && daysInStage >= minDays) {
      // Normal progression: advance to next stage
      return GrowthStage.fromIndex(currentStage.stageIndex + 1);
    }

    if (adjustedScore >= _delayedThreshold) {
      // Delayed progression: must wait extra days proportional to deficit
      const delayMultiplier = 1.5;
      final delayedMin = (minDays * delayMultiplier).round();
      if (daysInStage >= delayedMin) {
        return GrowthStage.fromIndex(currentStage.stageIndex + 1);
      }
      return currentStage; // not enough days yet, stay
    }

    // Critical / poor conditions: risk regression
    if (adjustedScore < _delayedThreshold && currentStage.stageIndex > 0) {
      return GrowthStage.fromIndex(currentStage.stageIndex - 1);
    }

    return currentStage;
  }
}

// ---------------------------------------------------------------------------
// Helper
// ---------------------------------------------------------------------------

class _Weights {
  const _Weights({
    required this.sun,
    required this.water,
    required this.soil,
  });

  final double sun;
  final double water;
  final double soil;
}
