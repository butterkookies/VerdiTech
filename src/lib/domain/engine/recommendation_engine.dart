import '../models/enums.dart';
import '../models/plant.dart';
import '../models/environment_profile.dart';
import '../models/recommendation.dart';

/// Generates plant-specific, season-aware care recommendations based on
/// the current environmental profile and plant type.
class RecommendationEngine {
  const RecommendationEngine();

  /// Return a prioritised list of [Recommendation]s for the given plant and
  /// environment. Returns an empty list when conditions are optimal.
  List<Recommendation> generate({
    required Plant plant,
    required EnvironmentProfile environment,
    required GrowthStage currentStage,
  }) {
    final tips = <Recommendation>[];

    tips.addAll(_waterTips(plant.type, environment, currentStage));
    tips.addAll(_sunlightTips(plant.type, environment, currentStage));
    tips.addAll(_soilTips(plant.type, environment, currentStage));
    tips.addAll(_seasonTips(plant.type, environment.season, currentStage));

    // Sort by priority (high first)
    tips.sort((a, b) => a.priority.index.compareTo(b.priority.index));
    return tips;
  }

  // ---------------------------------------------------------------------------
  // Water recommendations
  // ---------------------------------------------------------------------------

  List<Recommendation> _waterTips(
    PlantType type,
    EnvironmentProfile env,
    GrowthStage stage,
  ) {
    if (env.water >= 4) return [];

    final isLow = env.water <= 2;
    final priority =
        isLow ? RecommendationPriority.high : RecommendationPriority.medium;

    final tips = <String>[];

    if (type == PlantType.tomato) {
      if (env.season == Season.tagInit) {
        tips.add(
          'Tag-init heat causes rapid evaporation. Water tomatoes deeply every '
          'morning and evening until the top 2 inches of soil are fully moist.',
        );
      } else if (stage == GrowthStage.fruiting && isLow) {
        tips.add(
          'Inconsistent watering during fruiting causes blossom-end rot. '
          'Water deeply (about 1-2 liters for adult plants) every 1-2 days.',
        );
      } else if (isLow) {
        tips.add('Tomatoes need consistent moisture. Water until the top 2 inches '
            'are moist (Finger Test: soil should cling to your finger).');
      } else {
        tips.add('Tomato water levels are slightly below optimal. '
            'Aim for even, deep watering sessions every 2-3 days.');
      }
    } else if (type == PlantType.eggplant) {
      if (isLow) {
        tips.add('Eggplants need deep, consistent watering (about 1-1.5 inches of water per week). '
            'Water at the base until soil is moist 2 inches down.');
      } else {
        tips.add(
            'Eggplant moisture is slightly low. Water deeply every 2-3 days '
            'without flooding the roots.');
      }
    } else if (type == PlantType.silingLabuyo) {
      if (isLow) {
        tips.add(
          'Prolonged water stress reduces fruit size. Water deeply (until it drains) '
          'once the top 1 inch of soil feels completely dry.',
        );
      } else {
        tips.add('Siling Labuyo prefers slightly dry soil. Let the top 1-2 inches '
            'dry out before watering again to prevent root rot.');
      }
    }

    return tips
        .map((m) => Recommendation(
              category: 'Watering',
              priority: priority,
              message: m,
              forStage: stage,
            ))
        .toList();
  }

  // ---------------------------------------------------------------------------
  // Sunlight recommendations
  // ---------------------------------------------------------------------------

  List<Recommendation> _sunlightTips(
    PlantType type,
    EnvironmentProfile env,
    GrowthStage stage,
  ) {
    if (env.sunlight >= 4) return [];

    final isLow = env.sunlight <= 2;
    final priority =
        isLow ? RecommendationPriority.high : RecommendationPriority.medium;

    final message = switch ((type, isLow)) {
      (PlantType.tomato, true) =>
        'Tomatoes need 6–8 hours of direct sun. Move to a sunnier spot '
            'or thin out any overhead shade.',
      (PlantType.tomato, _) =>
        'Tomatoes prefer more sunlight. Ensure they receive at least '
            '4–6 hours of direct sunlight per day.',
      (PlantType.eggplant, true) =>
        'Eggplants require full sun (6-8 hours minimum). Low sunlight will significantly '
            'slow vegetative and flowering growth. Move to a sunnier spot.',
      (PlantType.eggplant, _) =>
        'Eggplant sunlight is slightly below optimal. Ensure they receive '
            'at least 6 hours of direct sun and are not shaded by neighbours.',
      (PlantType.silingLabuyo, true) =>
        'Siling Labuyo absolutely needs full sun to produce its characteristic '
            'heat. Relocate to a spot with at least 6 hours of direct sunlight.',
      (PlantType.silingLabuyo, _) =>
        'Siling Labuyo prefers full sun. Aim for 6+ hours to maximise '
            'fruit production and spiciness.',
    };

    return [
      Recommendation(
        category: 'Sunlight',
        priority: priority,
        message: message,
        forStage: stage,
      ),
    ];
  }

  // ---------------------------------------------------------------------------
  // Soil recommendations
  // ---------------------------------------------------------------------------

  List<Recommendation> _soilTips(
    PlantType type,
    EnvironmentProfile env,
    GrowthStage stage,
  ) {
    if (env.soil >= 4) return [];

    final isLow = env.soil <= 2;
    final priority =
        isLow ? RecommendationPriority.high : RecommendationPriority.medium;

    final message = switch (type) {
      PlantType.tomato when isLow =>
        'Tomatoes are heavy feeders. Add a 1-inch layer of compost '
            'or a balanced organic fertiliser to the topsoil every 3-4 weeks.',
      PlantType.tomato =>
        'Tomato soil quality is slightly below optimal. Top-dress with '
            'a handful of compost or worm castings around the base.',
      PlantType.eggplant when isLow =>
        'Eggplants need highly fertile soil. Mix in 1-2 inches of aged manure '
            'or compost into the topsoil to support its long vegetative phase.',
      PlantType.eggplant =>
        'Improve eggplant soil by scratching a handful of compost into the '
            'top layer of the soil.',
      PlantType.silingLabuyo when isLow =>
        'Siling Labuyo roots rot easily in heavy clay. If potted, ensure '
            'drainage holes are clear. Add sand or perlite to improve drainage.',
      _ => 'Improve soil quality by adding a 1-inch layer of compost.',
    };

    return [
      Recommendation(
        category: 'Soil',
        priority: priority,
        message: message,
        forStage: stage,
      ),
    ];
  }

  // ---------------------------------------------------------------------------
  // Season-specific recommendations
  // ---------------------------------------------------------------------------

  List<Recommendation> _seasonTips(
    PlantType type,
    Season season,
    GrowthStage stage,
  ) {
    final tips = <Recommendation>[];

    if (season == Season.tagUlan && type != PlantType.silingLabuyo) {
      tips.add(Recommendation(
        category: 'Disease Prevention',
        priority: RecommendationPriority.medium,
        message:
            'During Tag-ulan (rainy season), high humidity increases fungal '
            'disease risk. Ensure good air circulation and avoid overhead '
            'watering to keep leaves dry.',
        forStage: stage,
      ));
    }

    return tips;
  }
}
