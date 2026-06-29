import '../../domain/models/plant.dart';
import '../../domain/models/daily_log.dart';
import '../database/app_database.dart';

/// Repository providing a clean API over the [AppDatabase] for plant data.
///
/// ViewModels and Riverpod providers should interact with this class rather
/// than the DAOs directly.
class PlantRepository {
  const PlantRepository(this._db);

  final AppDatabase _db;

  // ---------------------------------------------------------------------------
  // Plant operations
  // ---------------------------------------------------------------------------

  /// Watch all plants in real-time.
  Stream<List<Plant>> watchAllPlants() => _db.plantDao.watchAllPlants();

  /// Fetch all plants once.
  Future<List<Plant>> getAllPlants() => _db.plantDao.getAllPlants();

  /// Fetch a single plant by id.
  Future<Plant?> getPlantById(int id) => _db.plantDao.getPlantById(id);

  /// Save a new plant. Returns the new plant with its assigned id.
  Future<Plant> addPlant(Plant plant) async {
    final id = await _db.plantDao.insertPlant(plant);
    return plant.copyWith(id: id);
  }

  /// Update an existing plant.
  Future<void> updatePlant(Plant plant) => _db.plantDao.updatePlant(plant);

  /// Delete a plant and all its associated daily logs.
  Future<void> deletePlant(int plantId) async {
    // Delete associated logs first
    final logs = await _db.dailyLogDao.getLogsForPlant(plantId);
    for (final log in logs) {
      if (log.id != null) {
        await _db.dailyLogDao.deleteLog(log.id!);
      }
    }
    await _db.plantDao.deletePlant(plantId);
  }

  // ---------------------------------------------------------------------------
  // Daily log operations
  // ---------------------------------------------------------------------------

  /// Watch all daily logs for a plant in real-time.
  Stream<List<DailyLog>> watchLogsForPlant(int plantId) =>
      _db.dailyLogDao.watchLogsForPlant(plantId);

  /// Fetch all daily logs for a plant once.
  Future<List<DailyLog>> getLogsForPlant(int plantId) =>
      _db.dailyLogDao.getLogsForPlant(plantId);

  /// Save or update a daily log for a specific date.
  Future<void> upsertLog(DailyLog log) => _db.dailyLogDao.upsertLog(log);

  /// Delete a single daily log entry.
  Future<void> deleteLog(int logId) => _db.dailyLogDao.deleteLog(logId);
}
