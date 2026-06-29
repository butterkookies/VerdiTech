import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/models/plant.dart';
import '../domain/models/environment_profile.dart';
import '../domain/models/day_prediction.dart';
import '../domain/models/recommendation.dart';
import '../domain/engine/ca_engine.dart';
import '../domain/engine/recommendation_engine.dart';

/// Singleton CA engine — pure, stateless; safe to share.
final caEngineProvider = Provider<CaEngine>((_) => const CaEngine());

/// Singleton recommendation engine.
final recommendationEngineProvider =
    Provider<RecommendationEngine>((_) => const RecommendationEngine());

// ---------------------------------------------------------------------------
// Per-plant prediction state
// ---------------------------------------------------------------------------

/// Derives an [EnvironmentProfile] from a [Plant]'s current scores.
final environmentProfileProvider =
    Provider.family<EnvironmentProfile, Plant>((ref, plant) {
  return EnvironmentProfile(
    sunlight: plant.sunlightScore,
    water: plant.waterScore,
    soil: plant.soilScore,
    season: plant.season,
  );
});

/// Computed environmental score for a plant (0.0–1.0).
final envScoreProvider = Provider.family<double, Plant>((ref, plant) {
  final engine = ref.watch(caEngineProvider);
  final env = ref.watch(environmentProfileProvider(plant));
  return engine.computeEnvScore(plant.type, env);
});

/// Generates a 60-day growth forecast for a plant.
final forecastProvider =
    Provider.family<List<DayPrediction>, Plant>((ref, plant) {
  final engine = ref.watch(caEngineProvider);
  final env = ref.watch(environmentProfileProvider(plant));
  return engine.forecast(plant: plant, environment: env, forecastDays: 60);
});

/// Estimates the number of days to harvest for a plant.
final daysToHarvestProvider = Provider.family<int, Plant>((ref, plant) {
  final engine = ref.watch(caEngineProvider);
  final env = ref.watch(environmentProfileProvider(plant));
  return engine.estimateDaysToHarvest(plant: plant, environment: env);
});

/// Generates care recommendations for a plant.
final recommendationsProvider =
    Provider.family<List<Recommendation>, Plant>((ref, plant) {
  final recEngine = ref.watch(recommendationEngineProvider);
  final env = ref.watch(environmentProfileProvider(plant));
  return recEngine.generate(
    plant: plant,
    environment: env,
    currentStage: plant.currentStage,
  );
});
