import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

import 'tables/plant_table.dart';
import 'tables/daily_log_table.dart';
import 'daos/plant_dao.dart';
import 'daos/daily_log_dao.dart';

part 'app_database.g.dart';

/// The Drift database that backs all local persistence for VerdiTech.
///
/// Run `flutter pub run build_runner build --delete-conflicting-outputs`
/// to generate the companion [_$AppDatabase] class.
@DriftDatabase(tables: [PlantTable, DailyLogTable], daos: [PlantDao, DailyLogDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  /// Constructor used in tests to pass an in-memory database.
  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) => m.createAll(),
        onUpgrade: (m, from, to) async {
          // Future migrations go here
        },
      );
}

/// Opens a [LazyDatabase] pointing at the app's document directory.
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'verditech.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
