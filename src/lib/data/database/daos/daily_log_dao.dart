import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/daily_log_table.dart';
import '../../mappers/daily_log_mapper.dart';
import '../../../domain/models/daily_log.dart';

part 'daily_log_dao.g.dart';

/// Data Access Object for [DailyLogTable] operations.
@DriftAccessor(tables: [DailyLogTable])
class DailyLogDao extends DatabaseAccessor<AppDatabase>
    with _$DailyLogDaoMixin {
  DailyLogDao(super.db);

  /// Watch all daily logs for a specific plant, ordered by date ascending.
  Stream<List<DailyLog>> watchLogsForPlant(int plantId) {
    return (select(dailyLogTable)
          ..where((t) => t.plantId.equals(plantId))
          ..orderBy([(t) => OrderingTerm.asc(t.date)]))
        .watch()
        .map((rows) => rows.map((row) => DailyLogMapper.fromRow(row)).toList());
  }

  /// Get all daily logs for a specific plant once.
  Future<List<DailyLog>> getLogsForPlant(int plantId) async {
    final rows = await (select(dailyLogTable)
          ..where((t) => t.plantId.equals(plantId))
          ..orderBy([(t) => OrderingTerm.asc(t.date)]))
        .get();
    return rows.map((row) => DailyLogMapper.fromRow(row)).toList();
  }

  /// Insert a new daily log. Returns the assigned id.
  Future<int> insertLog(DailyLog log) {
    return into(dailyLogTable).insert(DailyLogMapper.toCompanion(log));
  }

  /// Update an existing log.
  Future<bool> updateLog(DailyLog log) {
    return update(dailyLogTable).replace(DailyLogMapper.toCompanion(log));
  }

  /// Delete a log by id.
  Future<int> deleteLog(int id) {
    return (delete(dailyLogTable)..where((t) => t.id.equals(id))).go();
  }

  /// Upsert a log for a specific date (insert or update).
  Future<void> upsertLog(DailyLog log) async {
    await into(dailyLogTable).insertOnConflictUpdate(
      DailyLogMapper.toCompanion(log),
    );
  }
}
