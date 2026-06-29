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
          'Tag-init heat causes rapid evaporation. Water tomatoes every '
          'morning and evening to maintain even soil moisture.',
        );
      } else if (stage == GrowthStage.fruiting && isLow) {
        tips.add(
          'Inconsistent watering during fruiting can cause blossom-end rot '
          'or fruit cracking. Maintain steady moisture.',
        );
      } else if (isLow) {
        tips.add('Tomatoes need consistent moisture. Increase watering to at '
            'least once a day, especially during dry spells.');
      } else {
        tips.add('Tomato water levels are slightly below optimal. '
            'Aim for even, deep watering sessions.');
      }
    } else if (type == PlantType.eggplant) {
      if (isLow) {
        tips.add('Eggplants need deep, consistent watering. Water at the base '
            'and avoid wetting the leaves to prevent fungal disease.');
      } else {
        tips.add(
            'Eggplant moisture is slightly low. Water more consistently '
            'without flooding the roots.');
      }
    } else if (type == PlantType.silingLabuyo) {
      if (isLow) {
        tips.add(
          'Siling Labuyo is drought-tolerant but prolonged water stress '
          'reduces fruit size and spiciness. Increase watering slightly.',
        );
      } else {
        tips.add('Siling Labuyo prefers slightly dry soil between waterings. '
            'Avoid overwatering as it can cause root rot.');
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
        'Eggplants require full sun. Low sunlight will significantly slow '
            'vegetative and flowering growth.',
      (PlantType.eggplant, _) =>
        'Eggplant sunlight is slightly below optimal. Ensure the plant '
            'is not shaded by neighbouring plants.',
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
        'Tomatoes need rich, well-drained soil (pH 6.0–6.8). Add compost '
            'or organic fertiliser to improve nutrient levels.',
      PlantType.tomato =>
        'Tomato soil quality is slightly below optimal. Consider top-dressing '
            'with compost or a balanced fertiliser.',
      PlantType.eggplant when isLow =>
        'Eggplants thrive in fertile soil. Incorporate organic matter and '
            'ensure good drainage to avoid root disease.',
      PlantType.eggplant =>
        'Improve eggplant soil with compost or aged manure to support '
            'its longer vegetative phase.',
      PlantType.silingLabuyo when isLow =>
        'Siling Labuyo needs well-drained, moderately fertile soil. '
            'Avoid heavy clay; add sand and compost to improve drainage.',
      _ => 'Improve soil quality with compost or organic matter.',
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
