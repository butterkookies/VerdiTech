import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/plant_table.dart';
import '../../mappers/plant_mapper.dart';
import '../../../domain/models/plant.dart';

part 'plant_dao.g.dart';

/// Data Access Object for [PlantTable] operations.
@DriftAccessor(tables: [PlantTable])
class PlantDao extends DatabaseAccessor<AppDatabase> with _$PlantDaoMixin {
  PlantDao(super.db);

  /// Watch all plants, ordered by creation date descending.
  Stream<List<Plant>> watchAllPlants() {
    return (select(plantTable)
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .watch()
        .map((rows) => rows.map((row) => PlantMapper.fromRow(row)).toList());
  }

  /// Get all plants once.
  Future<List<Plant>> getAllPlants() async {
    final rows = await (select(plantTable)
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .get();
    return rows.map((row) => PlantMapper.fromRow(row)).toList();
  }

  /// Get a single plant by id.
  Future<Plant?> getPlantById(int id) async {
    final row = await (select(plantTable)
          ..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    return row == null ? null : PlantMapper.fromRow(row);
  }

  /// Insert a new plant. Returns the assigned id.
  Future<int> insertPlant(Plant plant) {
    return into(plantTable).insert(PlantMapper.toCompanion(plant));
  }

  /// Update an existing plant.
  Future<bool> updatePlant(Plant plant) {
    return update(plantTable).replace(PlantMapper.toCompanion(plant));
  }

  /// Delete a plant by id.
  Future<int> deletePlant(int id) {
    return (delete(plantTable)..where((t) => t.id.equals(id))).go();
  }
}
