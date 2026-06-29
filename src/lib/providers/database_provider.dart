import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/database/app_database.dart';
import '../data/repositories/plant_repository.dart';

/// Singleton [AppDatabase] instance shared across the app.
final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

/// Singleton [PlantRepository] backed by [databaseProvider].
final plantRepositoryProvider = Provider<PlantRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return PlantRepository(db);
});
