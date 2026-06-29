/// A single day's environmental factor log for a plant.
class DailyLog {
  DailyLog({
    this.id,
    required this.plantId,
    required this.date,
    required this.sunlightScore,
    required this.waterScore,
    required this.soilScore,
    this.note,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  final int? id;
  final int plantId;
  final DateTime date;

  /// Sunlight rating 1–5.
  final double sunlightScore;

  /// Water availability rating 1–5.
  final double waterScore;

  /// Soil quality rating 1–5.
  final double soilScore;

  final String? note;
  final DateTime createdAt;

  DailyLog copyWith({
    int? id,
    int? plantId,
    DateTime? date,
    double? sunlightScore,
    double? waterScore,
    double? soilScore,
    String? note,
    DateTime? createdAt,
  }) {
    return DailyLog(
      id: id ?? this.id,
      plantId: plantId ?? this.plantId,
      date: date ?? this.date,
      sunlightScore: sunlightScore ?? this.sunlightScore,
      waterScore: waterScore ?? this.waterScore,
      soilScore: soilScore ?? this.soilScore,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  String toString() =>
      'DailyLog(id: $id, plantId: $plantId, date: $date, '
      'sun: $sunlightScore, water: $waterScore, soil: $soilScore)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailyLog && id != null && id == other.id);

  @override
  int get hashCode => id.hashCode;
}
