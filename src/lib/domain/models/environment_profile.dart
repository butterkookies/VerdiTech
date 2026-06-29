import 'enums.dart';

/// Snapshot of environmental conditions used by the CA engine.
class EnvironmentProfile {
  const EnvironmentProfile({
    required this.sunlight,
    required this.water,
    required this.soil,
    required this.season,
  });

  /// Sunlight rating 1–5.
  final double sunlight;

  /// Water availability rating 1–5.
  final double water;

  /// Soil quality rating 1–5.
  final double soil;

  final Season season;

  EnvironmentProfile copyWith({
    double? sunlight,
    double? water,
    double? soil,
    Season? season,
  }) {
    return EnvironmentProfile(
      sunlight: sunlight ?? this.sunlight,
      water: water ?? this.water,
      soil: soil ?? this.soil,
      season: season ?? this.season,
    );
  }

  @override
  String toString() =>
      'EnvironmentProfile(sun: $sunlight, water: $water, '
      'soil: $soil, season: $season)';
}
