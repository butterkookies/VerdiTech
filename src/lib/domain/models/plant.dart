import 'enums.dart';

/// Domain model representing a tracked plant profile.
class Plant {
  Plant({
    this.id,
    required this.name,
    required this.type,
    required this.plantingDate,
    required this.currentStage,
    required this.sunlightScore,
    required this.waterScore,
    required this.soilScore,
    required this.season,
    this.notes,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  final int? id;
  final String name;
  final PlantType type;
  final DateTime plantingDate;
  final GrowthStage currentStage;

  /// Sunlight rating 1–5.
  final double sunlightScore;

  /// Water availability rating 1–5.
  final double waterScore;

  /// Soil quality rating 1–5.
  final double soilScore;

  final Season season;
  final String? notes;
  final DateTime createdAt;

  /// How many days have elapsed since the planting date.
  int get daysPlanted =>
      DateTime.now().difference(plantingDate).inDays.abs();

  Plant copyWith({
    int? id,
    String? name,
    PlantType? type,
    DateTime? plantingDate,
    GrowthStage? currentStage,
    double? sunlightScore,
    double? waterScore,
    double? soilScore,
    Season? season,
    String? notes,
    DateTime? createdAt,
  }) {
    return Plant(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      plantingDate: plantingDate ?? this.plantingDate,
      currentStage: currentStage ?? this.currentStage,
      sunlightScore: sunlightScore ?? this.sunlightScore,
      waterScore: waterScore ?? this.waterScore,
      soilScore: soilScore ?? this.soilScore,
      season: season ?? this.season,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  String toString() =>
      'Plant(id: $id, name: $name, type: $type, stage: $currentStage)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Plant && id != null && id == other.id);

  @override
  int get hashCode => id.hashCode;
}
