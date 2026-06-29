import 'package:drift/drift.dart';

import 'plant_table.dart';

/// Drift table definition for daily environmental factor logs.
class DailyLogTable extends Table {
  @override
  String get tableName => 'daily_logs';

  IntColumn get id => integer().autoIncrement()();

  /// Foreign key referencing [PlantTable.id].
  IntColumn get plantId =>
      integer().references(PlantTable, #id)();

  /// ISO-8601 date string (YYYY-MM-DD).
  TextColumn get date => text()();

  RealColumn get sunlightScore => real()();
  RealColumn get waterScore => real()();
  RealColumn get soilScore => real()();

  TextColumn get note => text().nullable()();

  TextColumn get createdAt => text()();
}
