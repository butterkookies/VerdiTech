import 'package:flutter_test/flutter_test.dart';

import 'package:verditech/domain/engine/ca_engine.dart';
import 'package:verditech/domain/models/enums.dart';
import 'package:verditech/domain/models/environment_profile.dart';
import 'package:verditech/domain/models/plant.dart';

void main() {
  const engine = CaEngine();

  // ---------------------------------------------------------------------------
  // Environmental score computation
  // ---------------------------------------------------------------------------
  group('CaEngine.computeEnvScore', () {
    test('Tomato: max scores + Malamig gives near-maximum adjusted score', () {
      const env = EnvironmentProfile(
        sunlight: 5,
        water: 5,
        soil: 5,
        season: Season.malamig,
      );
      final score = engine.computeEnvScore(PlantType.tomato, env);
      // Tomato weights: 0.35 sun + 0.40 water + 0.25 soil = 1.0
      // raw = (0.35*5 + 0.40*5 + 0.25*5) / 5 = 5/5 = 1.0
      // season modifier Malamig = 1.00 → adjusted = 1.0
      expect(score, closeTo(1.0, 0.001));
    });

    test('Tomato: max scores + Tag-ulan is penalised', () {
      const env = EnvironmentProfile(
        sunlight: 5,
        water: 5,
        soil: 5,
        season: Season.tagUlan,
      );
      final score = engine.computeEnvScore(PlantType.tomato, env);
      // season modifier Tag-ulan = 0.70 → adjusted = 0.70
      expect(score, closeTo(0.70, 0.001));
    });

    test('Eggplant: min scores gives very low adjusted score', () {
      const env = EnvironmentProfile(
        sunlight: 1,
        water: 1,
        soil: 1,
        season: Season.malamig,
      );
      final score = engine.computeEnvScore(PlantType.eggplant, env);
      // raw = (0.30*1 + 0.35*1 + 0.35*1) / 5 = 1/5 = 0.20
      // modifier Malamig = 0.95 → 0.19
      expect(score, closeTo(0.19, 0.01));
    });

    test('Siling Labuyo: moderate scores give expected value', () {
      const env = EnvironmentProfile(
        sunlight: 3,
        water: 3,
        soil: 3,
        season: Season.tagInit,
      );
      final score = engine.computeEnvScore(PlantType.silingLabuyo, env);
      // raw = (0.40*3 + 0.25*3 + 0.35*3) / 5 = 3/5 = 0.60
      // modifier Tag-init = 0.95 → 0.57
      expect(score, closeTo(0.57, 0.01));
    });
  });

  // ---------------------------------------------------------------------------
  // Forecast
  // ---------------------------------------------------------------------------
  group('CaEngine.forecast', () {
    test('Returns exactly the requested number of day predictions', () {
      final plant = Plant(
        name: 'Test Tomato',
        type: PlantType.tomato,
        plantingDate: DateTime.now().subtract(const Duration(days: 5)),
        currentStage: GrowthStage.seedling,
        sunlightScore: 5,
        waterScore: 5,
        soilScore: 5,
        season: Season.malamig,
      );
      const env = EnvironmentProfile(
        sunlight: 5,
        water: 5,
        soil: 5,
        season: Season.malamig,
      );
      final forecast = engine.forecast(
          plant: plant, environment: env, forecastDays: 30);
      expect(forecast.length, 30);
    });

    test('All stages in forecast are valid GrowthStage values', () {
      final plant = Plant(
        name: 'Test Eggplant',
        type: PlantType.eggplant,
        plantingDate: DateTime.now().subtract(const Duration(days: 10)),
        currentStage: GrowthStage.seedling,
        sunlightScore: 4,
        waterScore: 4,
        soilScore: 4,
        season: Season.malamig,
      );
      const env = EnvironmentProfile(
        sunlight: 4,
        water: 4,
        soil: 4,
        season: Season.malamig,
      );
      final forecast = engine.forecast(plant: plant, environment: env);
      for (final day in forecast) {
        expect(GrowthStage.values.contains(day.predictedStage), isTrue);
      }
    });

    test('Plant with optimal conditions eventually reaches harvestReady', () {
      final plant = Plant(
        name: 'Test Siling Labuyo',
        type: PlantType.silingLabuyo,
        plantingDate: DateTime.now().subtract(const Duration(days: 5)),
        currentStage: GrowthStage.seedling,
        sunlightScore: 5,
        waterScore: 5,
        soilScore: 5,
        season: Season.malamig,
      );
      const env = EnvironmentProfile(
        sunlight: 5,
        water: 5,
        soil: 5,
        season: Season.malamig,
      );
      final forecast = engine.forecast(
          plant: plant, environment: env, forecastDays: 120);
      final harvestDay =
          forecast.any((p) => p.predictedStage == GrowthStage.harvestReady);
      expect(harvestDay, isTrue,
          reason: 'Optimal conditions should reach harvest within 120 days');
    });

    test('Forecast stages never jump more than one step at a time', () {
      final plant = Plant(
        name: 'Progression Test',
        type: PlantType.tomato,
        plantingDate: DateTime.now().subtract(const Duration(days: 5)),
        currentStage: GrowthStage.seedling,
        sunlightScore: 5,
        waterScore: 5,
        soilScore: 5,
        season: Season.malamig,
      );
      const env = EnvironmentProfile(
        sunlight: 5,
        water: 5,
        soil: 5,
        season: Season.malamig,
      );
      final forecast =
          engine.forecast(plant: plant, environment: env, forecastDays: 80);
      for (int i = 1; i < forecast.length; i++) {
        final diff = (forecast[i].predictedStage.stageIndex -
                forecast[i - 1].predictedStage.stageIndex)
            .abs();
        expect(diff, lessThanOrEqualTo(1),
            reason: 'Stage should not skip more than one level per day');
      }
    });
  });

  // ---------------------------------------------------------------------------
  // estimateDaysToHarvest
  // ---------------------------------------------------------------------------
  group('CaEngine.estimateDaysToHarvest', () {
    test('Optimal conditions return a reasonable harvest estimate', () {
      final plant = Plant(
        name: 'Harvest Test',
        type: PlantType.tomato,
        plantingDate: DateTime.now().subtract(const Duration(days: 5)),
        currentStage: GrowthStage.seedling,
        sunlightScore: 5,
        waterScore: 5,
        soilScore: 5,
        season: Season.malamig,
      );
      const env = EnvironmentProfile(
        sunlight: 5,
        water: 5,
        soil: 5,
        season: Season.malamig,
      );
      final days = engine.estimateDaysToHarvest(plant: plant, environment: env);
      // Tomato seedling → harvest ≈ 60 days total; we planted 5 days ago
      // So ~55 days remaining. Allow generous range for the CA model.
      expect(days, greaterThan(0));
      expect(days, lessThan(180));
    });
  });

  // ---------------------------------------------------------------------------
  // Season.fromDate auto-detection
  // ---------------------------------------------------------------------------
  group('Season.fromDate', () {
    test('March is Tag-init', () {
      expect(Season.fromDate(DateTime(2026, 3, 15)), Season.tagInit);
    });
    test('July is Tag-ulan', () {
      expect(Season.fromDate(DateTime(2026, 7, 1)), Season.tagUlan);
    });
    test('December is Malamig', () {
      expect(Season.fromDate(DateTime(2026, 12, 1)), Season.malamig);
    });
    test('February is Malamig', () {
      expect(Season.fromDate(DateTime(2026, 2, 20)), Season.malamig);
    });
  });

  // ---------------------------------------------------------------------------
  // HealthStatus.fromScore
  // ---------------------------------------------------------------------------
  group('HealthStatus.fromScore', () {
    test('Score 1.0 → Excellent', () {
      expect(HealthStatus.fromScore(1.0), HealthStatus.excellent);
    });
    test('Score 0.70 → Good', () {
      expect(HealthStatus.fromScore(0.70), HealthStatus.good);
    });
    test('Score 0.50 → Fair', () {
      expect(HealthStatus.fromScore(0.50), HealthStatus.fair);
    });
    test('Score 0.25 → Poor', () {
      expect(HealthStatus.fromScore(0.25), HealthStatus.poor);
    });
    test('Score 0.10 → Critical', () {
      expect(HealthStatus.fromScore(0.10), HealthStatus.critical);
    });
  });
}
