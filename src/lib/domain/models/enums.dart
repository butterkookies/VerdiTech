/// Enums shared across the VerdiTech domain layer.
library enums;

/// Supported plant types for the prediction engine.
enum PlantType {
  tomato,
  eggplant,
  silingLabuyo;

  String get displayName {
    switch (this) {
      case PlantType.tomato:
        return 'Tomato';
      case PlantType.eggplant:
        return 'Eggplant';
      case PlantType.silingLabuyo:
        return 'Siling Labuyo';
    }
  }
}

/// Plant growth stages modelled by the 1D Cellular Automata engine.
enum GrowthStage {
  seedling,
  youngPlant,
  flowering,
  fruiting,
  harvestReady;

  String get displayName {
    switch (this) {
      case GrowthStage.seedling:
        return 'Seedling';
      case GrowthStage.youngPlant:
        return 'Young Plant';
      case GrowthStage.flowering:
        return 'Flowering';
      case GrowthStage.fruiting:
        return 'Fruiting';
      case GrowthStage.harvestReady:
        return 'Harvest Ready';
    }
  }

  int get stageIndex {
    switch (this) {
      case GrowthStage.seedling:
        return 0;
      case GrowthStage.youngPlant:
        return 1;
      case GrowthStage.flowering:
        return 2;
      case GrowthStage.fruiting:
        return 3;
      case GrowthStage.harvestReady:
        return 4;
    }
  }

  static GrowthStage fromIndex(int index) {
    return GrowthStage.values[index.clamp(0, GrowthStage.values.length - 1)];
  }
}

/// Philippine agricultural seasons, used as CA modifiers.
enum Season {
  tagInit,   // Dry/Hot — March–May
  tagUlan,   // Wet/Rainy — June–November
  malamig;   // Cool/Dry — December–February

  String get displayName {
    switch (this) {
      case Season.tagInit:
        return 'Tag-init (Dry Season)';
      case Season.tagUlan:
        return 'Tag-ulan (Rainy Season)';
      case Season.malamig:
        return 'Malamig (Cool Season)';
    }
  }

  /// Auto-detect season from a date.
  static Season fromDate(DateTime date) {
    final month = date.month;
    if (month >= 3 && month <= 5) return Season.tagInit;
    if (month >= 6 && month <= 11) return Season.tagUlan;
    return Season.malamig;
  }
}

/// Overall health status of a plant based on environmental score.
enum HealthStatus {
  excellent,
  good,
  fair,
  poor,
  critical;

  String get displayName {
    switch (this) {
      case HealthStatus.excellent:
        return 'Excellent';
      case HealthStatus.good:
        return 'Good';
      case HealthStatus.fair:
        return 'Fair';
      case HealthStatus.poor:
        return 'Poor';
      case HealthStatus.critical:
        return 'Critical';
    }
  }

  /// Derive health status from a normalised environmental score (0.0–1.0).
  static HealthStatus fromScore(double score) {
    if (score >= 0.80) return HealthStatus.excellent;
    if (score >= 0.60) return HealthStatus.good;
    if (score >= 0.40) return HealthStatus.fair;
    if (score >= 0.20) return HealthStatus.poor;
    return HealthStatus.critical;
  }
}

/// Priority level for a recommendation.
enum RecommendationPriority {
  high,
  medium,
  low;

  String get displayName {
    switch (this) {
      case RecommendationPriority.high:
        return 'High';
      case RecommendationPriority.medium:
        return 'Medium';
      case RecommendationPriority.low:
        return 'Low';
    }
  }
}
