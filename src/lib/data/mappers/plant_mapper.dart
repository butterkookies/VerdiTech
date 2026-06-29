import 'package:drift/drift.dart';

import '../database/app_database.dart';
import '../../domain/models/plant.dart';
import '../../domain/models/enums.dart';

/// Converts between [PlantTableData] (Drift row) and [Plant] (domain model).
class PlantMapper {
  const PlantMapper._();

  static Plant fromRow(PlantTableData row) {
    return Plant(
      id: row.id,
      name: row.name,
      type: PlantType.values.firstWhere((e) => e.name == row.type),
      plantingDate: DateTime.parse(row.plantingDate),
      currentStage:
          GrowthStage.values.firstWhere((e) => e.name == row.currentStage),
      sunlightScore: row.sunlightScore,
      waterScore: row.waterScore,
      soilScore: row.soilScore,
      season: Season.values.firstWhere((e) => e.name == row.season),
      notes: row.notes,
      createdAt: DateTime.parse(row.createdAt),
    );
  }

  static PlantTableCompanion toCompanion(Plant plant) {
    final now = DateTime.now().toIso8601String();
    return PlantTableCompanion(
      id: plant.id != null ? Value(plant.id!) : const Value.absent(),
      name: Value(plant.name),
      type: Value(plant.type.name),
      plantingDate: Value(plant.plantingDate.toIso8601String()),
      currentStage: Value(plant.currentStage.name),
      sunlightScore: Value(plant.sunlightScore),
      waterScore: Value(plant.waterScore),
      soilScore: Value(plant.soilScore),
      season: Value(plant.season.name),
      notes: Value(plant.notes),
      createdAt: Value(now),
    );
  }
}
