import 'package:drift/drift.dart';

import '../database/app_database.dart';
import '../../domain/models/daily_log.dart';

/// Converts between [DailyLogTableData] (Drift row) and [DailyLog] (domain model).
class DailyLogMapper {
  const DailyLogMapper._();

  static DailyLog fromRow(DailyLogTableData row) {
    return DailyLog(
      id: row.id,
      plantId: row.plantId,
      date: DateTime.parse(row.date),
      sunlightScore: row.sunlightScore,
      waterScore: row.waterScore,
      soilScore: row.soilScore,
      note: row.note,
      createdAt: DateTime.parse(row.createdAt),
    );
  }

  static DailyLogTableCompanion toCompanion(DailyLog log) {
    final now = DateTime.now().toIso8601String();
    return DailyLogTableCompanion(
      id: log.id != null ? Value(log.id!) : const Value.absent(),
      plantId: Value(log.plantId),
      date: Value(log.date.toIso8601String().substring(0, 10)), // YYYY-MM-DD
      sunlightScore: Value(log.sunlightScore),
      waterScore: Value(log.waterScore),
      soilScore: Value(log.soilScore),
      note: Value(log.note),
      createdAt: Value(now),
    );
  }
}
