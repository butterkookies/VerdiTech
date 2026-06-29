import 'enums.dart';

/// The CA engine's prediction for a single future day.
class DayPrediction {
  const DayPrediction({
    required this.dayOffset,
    required this.date,
    required this.predictedStage,
    required this.healthStatus,
    required this.environmentalScore,
    this.isHistorical = false,
  });

  /// How many days from planting this prediction represents.
  final int dayOffset;

  final DateTime date;

  final GrowthStage predictedStage;

  final HealthStatus healthStatus;

  /// Normalised environmental score (0.0–1.0) for this day.
  final double environmentalScore;

  /// True when this entry is backed by a real [DailyLog], false when it is
  /// a future CA forecast.
  final bool isHistorical;

  @override
  String toString() =>
      'DayPrediction(day: $dayOffset, stage: $predictedStage, '
      'health: $healthStatus, score: ${environmentalScore.toStringAsFixed(2)})';
}
