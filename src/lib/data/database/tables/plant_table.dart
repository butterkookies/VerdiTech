import 'package:drift/drift.dart';

/// Drift table definition for plant profiles.
class PlantTable extends Table {
  @override
  String get tableName => 'plants';

  IntColumn get id => integer().autoIncrement()();

  /// Display name given by the user.
  TextColumn get name => text().withLength(min: 1, max: 100)();

  /// Stored as string of [PlantType.name].
  TextColumn get type => text()();

  /// ISO-8601 date string.
  TextColumn get plantingDate => text()();

  /// Stored as string of [GrowthStage.name].
  TextColumn get currentStage => text()();

  RealColumn get sunlightScore => real()();
  RealColumn get waterScore => real()();
  RealColumn get soilScore => real()();

  /// Stored as string of [Season.name].
  TextColumn get season => text()();

  TextColumn get notes => text().nullable()();

  TextColumn get createdAt => text()();
}
