// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $PlantTableTable extends PlantTable
    with TableInfo<$PlantTableTable, PlantTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlantTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _plantingDateMeta =
      const VerificationMeta('plantingDate');
  @override
  late final GeneratedColumn<String> plantingDate = GeneratedColumn<String>(
      'planting_date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _currentStageMeta =
      const VerificationMeta('currentStage');
  @override
  late final GeneratedColumn<String> currentStage = GeneratedColumn<String>(
      'current_stage', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sunlightScoreMeta =
      const VerificationMeta('sunlightScore');
  @override
  late final GeneratedColumn<double> sunlightScore = GeneratedColumn<double>(
      'sunlight_score', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _waterScoreMeta =
      const VerificationMeta('waterScore');
  @override
  late final GeneratedColumn<double> waterScore = GeneratedColumn<double>(
      'water_score', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _soilScoreMeta =
      const VerificationMeta('soilScore');
  @override
  late final GeneratedColumn<double> soilScore = GeneratedColumn<double>(
      'soil_score', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _seasonMeta = const VerificationMeta('season');
  @override
  late final GeneratedColumn<String> season = GeneratedColumn<String>(
      'season', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
      'created_at', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        type,
        plantingDate,
        currentStage,
        sunlightScore,
        waterScore,
        soilScore,
        season,
        notes,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'plants';
  @override
  VerificationContext validateIntegrity(Insertable<PlantTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('planting_date')) {
      context.handle(
          _plantingDateMeta,
          plantingDate.isAcceptableOrUnknown(
              data['planting_date']!, _plantingDateMeta));
    } else if (isInserting) {
      context.missing(_plantingDateMeta);
    }
    if (data.containsKey('current_stage')) {
      context.handle(
          _currentStageMeta,
          currentStage.isAcceptableOrUnknown(
              data['current_stage']!, _currentStageMeta));
    } else if (isInserting) {
      context.missing(_currentStageMeta);
    }
    if (data.containsKey('sunlight_score')) {
      context.handle(
          _sunlightScoreMeta,
          sunlightScore.isAcceptableOrUnknown(
              data['sunlight_score']!, _sunlightScoreMeta));
    } else if (isInserting) {
      context.missing(_sunlightScoreMeta);
    }
    if (data.containsKey('water_score')) {
      context.handle(
          _waterScoreMeta,
          waterScore.isAcceptableOrUnknown(
              data['water_score']!, _waterScoreMeta));
    } else if (isInserting) {
      context.missing(_waterScoreMeta);
    }
    if (data.containsKey('soil_score')) {
      context.handle(_soilScoreMeta,
          soilScore.isAcceptableOrUnknown(data['soil_score']!, _soilScoreMeta));
    } else if (isInserting) {
      context.missing(_soilScoreMeta);
    }
    if (data.containsKey('season')) {
      context.handle(_seasonMeta,
          season.isAcceptableOrUnknown(data['season']!, _seasonMeta));
    } else if (isInserting) {
      context.missing(_seasonMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PlantTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlantTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      plantingDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}planting_date'])!,
      currentStage: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}current_stage'])!,
      sunlightScore: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}sunlight_score'])!,
      waterScore: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}water_score'])!,
      soilScore: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}soil_score'])!,
      season: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}season'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $PlantTableTable createAlias(String alias) {
    return $PlantTableTable(attachedDatabase, alias);
  }
}

class PlantTableData extends DataClass implements Insertable<PlantTableData> {
  final int id;

  /// Display name given by the user.
  final String name;

  /// Stored as string of [PlantType.name].
  final String type;

  /// ISO-8601 date string.
  final String plantingDate;

  /// Stored as string of [GrowthStage.name].
  final String currentStage;
  final double sunlightScore;
  final double waterScore;
  final double soilScore;

  /// Stored as string of [Season.name].
  final String season;
  final String? notes;
  final String createdAt;
  const PlantTableData(
      {required this.id,
      required this.name,
      required this.type,
      required this.plantingDate,
      required this.currentStage,
      required this.sunlightScore,
      required this.waterScore,
      required this.soilScore,
      required this.season,
      this.notes,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['type'] = Variable<String>(type);
    map['planting_date'] = Variable<String>(plantingDate);
    map['current_stage'] = Variable<String>(currentStage);
    map['sunlight_score'] = Variable<double>(sunlightScore);
    map['water_score'] = Variable<double>(waterScore);
    map['soil_score'] = Variable<double>(soilScore);
    map['season'] = Variable<String>(season);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<String>(createdAt);
    return map;
  }

  PlantTableCompanion toCompanion(bool nullToAbsent) {
    return PlantTableCompanion(
      id: Value(id),
      name: Value(name),
      type: Value(type),
      plantingDate: Value(plantingDate),
      currentStage: Value(currentStage),
      sunlightScore: Value(sunlightScore),
      waterScore: Value(waterScore),
      soilScore: Value(soilScore),
      season: Value(season),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      createdAt: Value(createdAt),
    );
  }

  factory PlantTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlantTableData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      type: serializer.fromJson<String>(json['type']),
      plantingDate: serializer.fromJson<String>(json['plantingDate']),
      currentStage: serializer.fromJson<String>(json['currentStage']),
      sunlightScore: serializer.fromJson<double>(json['sunlightScore']),
      waterScore: serializer.fromJson<double>(json['waterScore']),
      soilScore: serializer.fromJson<double>(json['soilScore']),
      season: serializer.fromJson<String>(json['season']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'type': serializer.toJson<String>(type),
      'plantingDate': serializer.toJson<String>(plantingDate),
      'currentStage': serializer.toJson<String>(currentStage),
      'sunlightScore': serializer.toJson<double>(sunlightScore),
      'waterScore': serializer.toJson<double>(waterScore),
      'soilScore': serializer.toJson<double>(soilScore),
      'season': serializer.toJson<String>(season),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<String>(createdAt),
    };
  }

  PlantTableData copyWith(
          {int? id,
          String? name,
          String? type,
          String? plantingDate,
          String? currentStage,
          double? sunlightScore,
          double? waterScore,
          double? soilScore,
          String? season,
          Value<String?> notes = const Value.absent(),
          String? createdAt}) =>
      PlantTableData(
        id: id ?? this.id,
        name: name ?? this.name,
        type: type ?? this.type,
        plantingDate: plantingDate ?? this.plantingDate,
        currentStage: currentStage ?? this.currentStage,
        sunlightScore: sunlightScore ?? this.sunlightScore,
        waterScore: waterScore ?? this.waterScore,
        soilScore: soilScore ?? this.soilScore,
        season: season ?? this.season,
        notes: notes.present ? notes.value : this.notes,
        createdAt: createdAt ?? this.createdAt,
      );
  PlantTableData copyWithCompanion(PlantTableCompanion data) {
    return PlantTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      type: data.type.present ? data.type.value : this.type,
      plantingDate: data.plantingDate.present
          ? data.plantingDate.value
          : this.plantingDate,
      currentStage: data.currentStage.present
          ? data.currentStage.value
          : this.currentStage,
      sunlightScore: data.sunlightScore.present
          ? data.sunlightScore.value
          : this.sunlightScore,
      waterScore:
          data.waterScore.present ? data.waterScore.value : this.waterScore,
      soilScore: data.soilScore.present ? data.soilScore.value : this.soilScore,
      season: data.season.present ? data.season.value : this.season,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PlantTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('plantingDate: $plantingDate, ')
          ..write('currentStage: $currentStage, ')
          ..write('sunlightScore: $sunlightScore, ')
          ..write('waterScore: $waterScore, ')
          ..write('soilScore: $soilScore, ')
          ..write('season: $season, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, type, plantingDate, currentStage,
      sunlightScore, waterScore, soilScore, season, notes, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlantTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.type == this.type &&
          other.plantingDate == this.plantingDate &&
          other.currentStage == this.currentStage &&
          other.sunlightScore == this.sunlightScore &&
          other.waterScore == this.waterScore &&
          other.soilScore == this.soilScore &&
          other.season == this.season &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt);
}

class PlantTableCompanion extends UpdateCompanion<PlantTableData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> type;
  final Value<String> plantingDate;
  final Value<String> currentStage;
  final Value<double> sunlightScore;
  final Value<double> waterScore;
  final Value<double> soilScore;
  final Value<String> season;
  final Value<String?> notes;
  final Value<String> createdAt;
  const PlantTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.plantingDate = const Value.absent(),
    this.currentStage = const Value.absent(),
    this.sunlightScore = const Value.absent(),
    this.waterScore = const Value.absent(),
    this.soilScore = const Value.absent(),
    this.season = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  PlantTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String type,
    required String plantingDate,
    required String currentStage,
    required double sunlightScore,
    required double waterScore,
    required double soilScore,
    required String season,
    this.notes = const Value.absent(),
    required String createdAt,
  })  : name = Value(name),
        type = Value(type),
        plantingDate = Value(plantingDate),
        currentStage = Value(currentStage),
        sunlightScore = Value(sunlightScore),
        waterScore = Value(waterScore),
        soilScore = Value(soilScore),
        season = Value(season),
        createdAt = Value(createdAt);
  static Insertable<PlantTableData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? type,
    Expression<String>? plantingDate,
    Expression<String>? currentStage,
    Expression<double>? sunlightScore,
    Expression<double>? waterScore,
    Expression<double>? soilScore,
    Expression<String>? season,
    Expression<String>? notes,
    Expression<String>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (plantingDate != null) 'planting_date': plantingDate,
      if (currentStage != null) 'current_stage': currentStage,
      if (sunlightScore != null) 'sunlight_score': sunlightScore,
      if (waterScore != null) 'water_score': waterScore,
      if (soilScore != null) 'soil_score': soilScore,
      if (season != null) 'season': season,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  PlantTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? type,
      Value<String>? plantingDate,
      Value<String>? currentStage,
      Value<double>? sunlightScore,
      Value<double>? waterScore,
      Value<double>? soilScore,
      Value<String>? season,
      Value<String?>? notes,
      Value<String>? createdAt}) {
    return PlantTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      plantingDate: plantingDate ?? this.plantingDate,
      currentStage: currentStage ?? this.currentStage,
      sunlightScore: sunlightScore ?? this.sunlightScore,
      waterScore: waterScore ?? this.waterScore,
      soilScore: soilScore ?? this.soilScore,
      season: season ?? this.season,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (plantingDate.present) {
      map['planting_date'] = Variable<String>(plantingDate.value);
    }
    if (currentStage.present) {
      map['current_stage'] = Variable<String>(currentStage.value);
    }
    if (sunlightScore.present) {
      map['sunlight_score'] = Variable<double>(sunlightScore.value);
    }
    if (waterScore.present) {
      map['water_score'] = Variable<double>(waterScore.value);
    }
    if (soilScore.present) {
      map['soil_score'] = Variable<double>(soilScore.value);
    }
    if (season.present) {
      map['season'] = Variable<String>(season.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlantTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('plantingDate: $plantingDate, ')
          ..write('currentStage: $currentStage, ')
          ..write('sunlightScore: $sunlightScore, ')
          ..write('waterScore: $waterScore, ')
          ..write('soilScore: $soilScore, ')
          ..write('season: $season, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $DailyLogTableTable extends DailyLogTable
    with TableInfo<$DailyLogTableTable, DailyLogTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DailyLogTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _plantIdMeta =
      const VerificationMeta('plantId');
  @override
  late final GeneratedColumn<int> plantId = GeneratedColumn<int>(
      'plant_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES plants (id)'));
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
      'date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sunlightScoreMeta =
      const VerificationMeta('sunlightScore');
  @override
  late final GeneratedColumn<double> sunlightScore = GeneratedColumn<double>(
      'sunlight_score', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _waterScoreMeta =
      const VerificationMeta('waterScore');
  @override
  late final GeneratedColumn<double> waterScore = GeneratedColumn<double>(
      'water_score', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _soilScoreMeta =
      const VerificationMeta('soilScore');
  @override
  late final GeneratedColumn<double> soilScore = GeneratedColumn<double>(
      'soil_score', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
      'note', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
      'created_at', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        plantId,
        date,
        sunlightScore,
        waterScore,
        soilScore,
        note,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'daily_logs';
  @override
  VerificationContext validateIntegrity(Insertable<DailyLogTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('plant_id')) {
      context.handle(_plantIdMeta,
          plantId.isAcceptableOrUnknown(data['plant_id']!, _plantIdMeta));
    } else if (isInserting) {
      context.missing(_plantIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('sunlight_score')) {
      context.handle(
          _sunlightScoreMeta,
          sunlightScore.isAcceptableOrUnknown(
              data['sunlight_score']!, _sunlightScoreMeta));
    } else if (isInserting) {
      context.missing(_sunlightScoreMeta);
    }
    if (data.containsKey('water_score')) {
      context.handle(
          _waterScoreMeta,
          waterScore.isAcceptableOrUnknown(
              data['water_score']!, _waterScoreMeta));
    } else if (isInserting) {
      context.missing(_waterScoreMeta);
    }
    if (data.containsKey('soil_score')) {
      context.handle(_soilScoreMeta,
          soilScore.isAcceptableOrUnknown(data['soil_score']!, _soilScoreMeta));
    } else if (isInserting) {
      context.missing(_soilScoreMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DailyLogTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DailyLogTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      plantId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}plant_id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}date'])!,
      sunlightScore: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}sunlight_score'])!,
      waterScore: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}water_score'])!,
      soilScore: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}soil_score'])!,
      note: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $DailyLogTableTable createAlias(String alias) {
    return $DailyLogTableTable(attachedDatabase, alias);
  }
}

class DailyLogTableData extends DataClass
    implements Insertable<DailyLogTableData> {
  final int id;

  /// Foreign key referencing [PlantTable.id].
  final int plantId;

  /// ISO-8601 date string (YYYY-MM-DD).
  final String date;
  final double sunlightScore;
  final double waterScore;
  final double soilScore;
  final String? note;
  final String createdAt;
  const DailyLogTableData(
      {required this.id,
      required this.plantId,
      required this.date,
      required this.sunlightScore,
      required this.waterScore,
      required this.soilScore,
      this.note,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['plant_id'] = Variable<int>(plantId);
    map['date'] = Variable<String>(date);
    map['sunlight_score'] = Variable<double>(sunlightScore);
    map['water_score'] = Variable<double>(waterScore);
    map['soil_score'] = Variable<double>(soilScore);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['created_at'] = Variable<String>(createdAt);
    return map;
  }

  DailyLogTableCompanion toCompanion(bool nullToAbsent) {
    return DailyLogTableCompanion(
      id: Value(id),
      plantId: Value(plantId),
      date: Value(date),
      sunlightScore: Value(sunlightScore),
      waterScore: Value(waterScore),
      soilScore: Value(soilScore),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      createdAt: Value(createdAt),
    );
  }

  factory DailyLogTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DailyLogTableData(
      id: serializer.fromJson<int>(json['id']),
      plantId: serializer.fromJson<int>(json['plantId']),
      date: serializer.fromJson<String>(json['date']),
      sunlightScore: serializer.fromJson<double>(json['sunlightScore']),
      waterScore: serializer.fromJson<double>(json['waterScore']),
      soilScore: serializer.fromJson<double>(json['soilScore']),
      note: serializer.fromJson<String?>(json['note']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'plantId': serializer.toJson<int>(plantId),
      'date': serializer.toJson<String>(date),
      'sunlightScore': serializer.toJson<double>(sunlightScore),
      'waterScore': serializer.toJson<double>(waterScore),
      'soilScore': serializer.toJson<double>(soilScore),
      'note': serializer.toJson<String?>(note),
      'createdAt': serializer.toJson<String>(createdAt),
    };
  }

  DailyLogTableData copyWith(
          {int? id,
          int? plantId,
          String? date,
          double? sunlightScore,
          double? waterScore,
          double? soilScore,
          Value<String?> note = const Value.absent(),
          String? createdAt}) =>
      DailyLogTableData(
        id: id ?? this.id,
        plantId: plantId ?? this.plantId,
        date: date ?? this.date,
        sunlightScore: sunlightScore ?? this.sunlightScore,
        waterScore: waterScore ?? this.waterScore,
        soilScore: soilScore ?? this.soilScore,
        note: note.present ? note.value : this.note,
        createdAt: createdAt ?? this.createdAt,
      );
  DailyLogTableData copyWithCompanion(DailyLogTableCompanion data) {
    return DailyLogTableData(
      id: data.id.present ? data.id.value : this.id,
      plantId: data.plantId.present ? data.plantId.value : this.plantId,
      date: data.date.present ? data.date.value : this.date,
      sunlightScore: data.sunlightScore.present
          ? data.sunlightScore.value
          : this.sunlightScore,
      waterScore:
          data.waterScore.present ? data.waterScore.value : this.waterScore,
      soilScore: data.soilScore.present ? data.soilScore.value : this.soilScore,
      note: data.note.present ? data.note.value : this.note,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DailyLogTableData(')
          ..write('id: $id, ')
          ..write('plantId: $plantId, ')
          ..write('date: $date, ')
          ..write('sunlightScore: $sunlightScore, ')
          ..write('waterScore: $waterScore, ')
          ..write('soilScore: $soilScore, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, plantId, date, sunlightScore, waterScore, soilScore, note, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailyLogTableData &&
          other.id == this.id &&
          other.plantId == this.plantId &&
          other.date == this.date &&
          other.sunlightScore == this.sunlightScore &&
          other.waterScore == this.waterScore &&
          other.soilScore == this.soilScore &&
          other.note == this.note &&
          other.createdAt == this.createdAt);
}

class DailyLogTableCompanion extends UpdateCompanion<DailyLogTableData> {
  final Value<int> id;
  final Value<int> plantId;
  final Value<String> date;
  final Value<double> sunlightScore;
  final Value<double> waterScore;
  final Value<double> soilScore;
  final Value<String?> note;
  final Value<String> createdAt;
  const DailyLogTableCompanion({
    this.id = const Value.absent(),
    this.plantId = const Value.absent(),
    this.date = const Value.absent(),
    this.sunlightScore = const Value.absent(),
    this.waterScore = const Value.absent(),
    this.soilScore = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  DailyLogTableCompanion.insert({
    this.id = const Value.absent(),
    required int plantId,
    required String date,
    required double sunlightScore,
    required double waterScore,
    required double soilScore,
    this.note = const Value.absent(),
    required String createdAt,
  })  : plantId = Value(plantId),
        date = Value(date),
        sunlightScore = Value(sunlightScore),
        waterScore = Value(waterScore),
        soilScore = Value(soilScore),
        createdAt = Value(createdAt);
  static Insertable<DailyLogTableData> custom({
    Expression<int>? id,
    Expression<int>? plantId,
    Expression<String>? date,
    Expression<double>? sunlightScore,
    Expression<double>? waterScore,
    Expression<double>? soilScore,
    Expression<String>? note,
    Expression<String>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (plantId != null) 'plant_id': plantId,
      if (date != null) 'date': date,
      if (sunlightScore != null) 'sunlight_score': sunlightScore,
      if (waterScore != null) 'water_score': waterScore,
      if (soilScore != null) 'soil_score': soilScore,
      if (note != null) 'note': note,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  DailyLogTableCompanion copyWith(
      {Value<int>? id,
      Value<int>? plantId,
      Value<String>? date,
      Value<double>? sunlightScore,
      Value<double>? waterScore,
      Value<double>? soilScore,
      Value<String?>? note,
      Value<String>? createdAt}) {
    return DailyLogTableCompanion(
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
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (plantId.present) {
      map['plant_id'] = Variable<int>(plantId.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (sunlightScore.present) {
      map['sunlight_score'] = Variable<double>(sunlightScore.value);
    }
    if (waterScore.present) {
      map['water_score'] = Variable<double>(waterScore.value);
    }
    if (soilScore.present) {
      map['soil_score'] = Variable<double>(soilScore.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DailyLogTableCompanion(')
          ..write('id: $id, ')
          ..write('plantId: $plantId, ')
          ..write('date: $date, ')
          ..write('sunlightScore: $sunlightScore, ')
          ..write('waterScore: $waterScore, ')
          ..write('soilScore: $soilScore, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PlantTableTable plantTable = $PlantTableTable(this);
  late final $DailyLogTableTable dailyLogTable = $DailyLogTableTable(this);
  late final PlantDao plantDao = PlantDao(this as AppDatabase);
  late final DailyLogDao dailyLogDao = DailyLogDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [plantTable, dailyLogTable];
}

typedef $$PlantTableTableCreateCompanionBuilder = PlantTableCompanion Function({
  Value<int> id,
  required String name,
  required String type,
  required String plantingDate,
  required String currentStage,
  required double sunlightScore,
  required double waterScore,
  required double soilScore,
  required String season,
  Value<String?> notes,
  required String createdAt,
});
typedef $$PlantTableTableUpdateCompanionBuilder = PlantTableCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String> type,
  Value<String> plantingDate,
  Value<String> currentStage,
  Value<double> sunlightScore,
  Value<double> waterScore,
  Value<double> soilScore,
  Value<String> season,
  Value<String?> notes,
  Value<String> createdAt,
});

final class $$PlantTableTableReferences
    extends BaseReferences<_$AppDatabase, $PlantTableTable, PlantTableData> {
  $$PlantTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$DailyLogTableTable, List<DailyLogTableData>>
      _dailyLogTableRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.dailyLogTable,
              aliasName: $_aliasNameGenerator(
                  db.plantTable.id, db.dailyLogTable.plantId));

  $$DailyLogTableTableProcessedTableManager get dailyLogTableRefs {
    final manager = $$DailyLogTableTableTableManager($_db, $_db.dailyLogTable)
        .filter((f) => f.plantId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_dailyLogTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$PlantTableTableFilterComposer
    extends Composer<_$AppDatabase, $PlantTableTable> {
  $$PlantTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get plantingDate => $composableBuilder(
      column: $table.plantingDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get currentStage => $composableBuilder(
      column: $table.currentStage, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get sunlightScore => $composableBuilder(
      column: $table.sunlightScore, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get waterScore => $composableBuilder(
      column: $table.waterScore, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get soilScore => $composableBuilder(
      column: $table.soilScore, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get season => $composableBuilder(
      column: $table.season, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  Expression<bool> dailyLogTableRefs(
      Expression<bool> Function($$DailyLogTableTableFilterComposer f) f) {
    final $$DailyLogTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.dailyLogTable,
        getReferencedColumn: (t) => t.plantId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DailyLogTableTableFilterComposer(
              $db: $db,
              $table: $db.dailyLogTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$PlantTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PlantTableTable> {
  $$PlantTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get plantingDate => $composableBuilder(
      column: $table.plantingDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get currentStage => $composableBuilder(
      column: $table.currentStage,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get sunlightScore => $composableBuilder(
      column: $table.sunlightScore,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get waterScore => $composableBuilder(
      column: $table.waterScore, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get soilScore => $composableBuilder(
      column: $table.soilScore, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get season => $composableBuilder(
      column: $table.season, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$PlantTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlantTableTable> {
  $$PlantTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get plantingDate => $composableBuilder(
      column: $table.plantingDate, builder: (column) => column);

  GeneratedColumn<String> get currentStage => $composableBuilder(
      column: $table.currentStage, builder: (column) => column);

  GeneratedColumn<double> get sunlightScore => $composableBuilder(
      column: $table.sunlightScore, builder: (column) => column);

  GeneratedColumn<double> get waterScore => $composableBuilder(
      column: $table.waterScore, builder: (column) => column);

  GeneratedColumn<double> get soilScore =>
      $composableBuilder(column: $table.soilScore, builder: (column) => column);

  GeneratedColumn<String> get season =>
      $composableBuilder(column: $table.season, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> dailyLogTableRefs<T extends Object>(
      Expression<T> Function($$DailyLogTableTableAnnotationComposer a) f) {
    final $$DailyLogTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.dailyLogTable,
        getReferencedColumn: (t) => t.plantId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DailyLogTableTableAnnotationComposer(
              $db: $db,
              $table: $db.dailyLogTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$PlantTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PlantTableTable,
    PlantTableData,
    $$PlantTableTableFilterComposer,
    $$PlantTableTableOrderingComposer,
    $$PlantTableTableAnnotationComposer,
    $$PlantTableTableCreateCompanionBuilder,
    $$PlantTableTableUpdateCompanionBuilder,
    (PlantTableData, $$PlantTableTableReferences),
    PlantTableData,
    PrefetchHooks Function({bool dailyLogTableRefs})> {
  $$PlantTableTableTableManager(_$AppDatabase db, $PlantTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlantTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlantTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlantTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<String> plantingDate = const Value.absent(),
            Value<String> currentStage = const Value.absent(),
            Value<double> sunlightScore = const Value.absent(),
            Value<double> waterScore = const Value.absent(),
            Value<double> soilScore = const Value.absent(),
            Value<String> season = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<String> createdAt = const Value.absent(),
          }) =>
              PlantTableCompanion(
            id: id,
            name: name,
            type: type,
            plantingDate: plantingDate,
            currentStage: currentStage,
            sunlightScore: sunlightScore,
            waterScore: waterScore,
            soilScore: soilScore,
            season: season,
            notes: notes,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required String type,
            required String plantingDate,
            required String currentStage,
            required double sunlightScore,
            required double waterScore,
            required double soilScore,
            required String season,
            Value<String?> notes = const Value.absent(),
            required String createdAt,
          }) =>
              PlantTableCompanion.insert(
            id: id,
            name: name,
            type: type,
            plantingDate: plantingDate,
            currentStage: currentStage,
            sunlightScore: sunlightScore,
            waterScore: waterScore,
            soilScore: soilScore,
            season: season,
            notes: notes,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$PlantTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({dailyLogTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (dailyLogTableRefs) db.dailyLogTable
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (dailyLogTableRefs)
                    await $_getPrefetchedData<PlantTableData, $PlantTableTable,
                            DailyLogTableData>(
                        currentTable: table,
                        referencedTable: $$PlantTableTableReferences
                            ._dailyLogTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$PlantTableTableReferences(db, table, p0)
                                .dailyLogTableRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.plantId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$PlantTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PlantTableTable,
    PlantTableData,
    $$PlantTableTableFilterComposer,
    $$PlantTableTableOrderingComposer,
    $$PlantTableTableAnnotationComposer,
    $$PlantTableTableCreateCompanionBuilder,
    $$PlantTableTableUpdateCompanionBuilder,
    (PlantTableData, $$PlantTableTableReferences),
    PlantTableData,
    PrefetchHooks Function({bool dailyLogTableRefs})>;
typedef $$DailyLogTableTableCreateCompanionBuilder = DailyLogTableCompanion
    Function({
  Value<int> id,
  required int plantId,
  required String date,
  required double sunlightScore,
  required double waterScore,
  required double soilScore,
  Value<String?> note,
  required String createdAt,
});
typedef $$DailyLogTableTableUpdateCompanionBuilder = DailyLogTableCompanion
    Function({
  Value<int> id,
  Value<int> plantId,
  Value<String> date,
  Value<double> sunlightScore,
  Value<double> waterScore,
  Value<double> soilScore,
  Value<String?> note,
  Value<String> createdAt,
});

final class $$DailyLogTableTableReferences extends BaseReferences<_$AppDatabase,
    $DailyLogTableTable, DailyLogTableData> {
  $$DailyLogTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $PlantTableTable _plantIdTable(_$AppDatabase db) =>
      db.plantTable.createAlias(
          $_aliasNameGenerator(db.dailyLogTable.plantId, db.plantTable.id));

  $$PlantTableTableProcessedTableManager get plantId {
    final $_column = $_itemColumn<int>('plant_id')!;

    final manager = $$PlantTableTableTableManager($_db, $_db.plantTable)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_plantIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$DailyLogTableTableFilterComposer
    extends Composer<_$AppDatabase, $DailyLogTableTable> {
  $$DailyLogTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get sunlightScore => $composableBuilder(
      column: $table.sunlightScore, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get waterScore => $composableBuilder(
      column: $table.waterScore, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get soilScore => $composableBuilder(
      column: $table.soilScore, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$PlantTableTableFilterComposer get plantId {
    final $$PlantTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.plantId,
        referencedTable: $db.plantTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlantTableTableFilterComposer(
              $db: $db,
              $table: $db.plantTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DailyLogTableTableOrderingComposer
    extends Composer<_$AppDatabase, $DailyLogTableTable> {
  $$DailyLogTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get sunlightScore => $composableBuilder(
      column: $table.sunlightScore,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get waterScore => $composableBuilder(
      column: $table.waterScore, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get soilScore => $composableBuilder(
      column: $table.soilScore, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$PlantTableTableOrderingComposer get plantId {
    final $$PlantTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.plantId,
        referencedTable: $db.plantTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlantTableTableOrderingComposer(
              $db: $db,
              $table: $db.plantTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DailyLogTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $DailyLogTableTable> {
  $$DailyLogTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<double> get sunlightScore => $composableBuilder(
      column: $table.sunlightScore, builder: (column) => column);

  GeneratedColumn<double> get waterScore => $composableBuilder(
      column: $table.waterScore, builder: (column) => column);

  GeneratedColumn<double> get soilScore =>
      $composableBuilder(column: $table.soilScore, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$PlantTableTableAnnotationComposer get plantId {
    final $$PlantTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.plantId,
        referencedTable: $db.plantTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlantTableTableAnnotationComposer(
              $db: $db,
              $table: $db.plantTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DailyLogTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DailyLogTableTable,
    DailyLogTableData,
    $$DailyLogTableTableFilterComposer,
    $$DailyLogTableTableOrderingComposer,
    $$DailyLogTableTableAnnotationComposer,
    $$DailyLogTableTableCreateCompanionBuilder,
    $$DailyLogTableTableUpdateCompanionBuilder,
    (DailyLogTableData, $$DailyLogTableTableReferences),
    DailyLogTableData,
    PrefetchHooks Function({bool plantId})> {
  $$DailyLogTableTableTableManager(_$AppDatabase db, $DailyLogTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DailyLogTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DailyLogTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DailyLogTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> plantId = const Value.absent(),
            Value<String> date = const Value.absent(),
            Value<double> sunlightScore = const Value.absent(),
            Value<double> waterScore = const Value.absent(),
            Value<double> soilScore = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<String> createdAt = const Value.absent(),
          }) =>
              DailyLogTableCompanion(
            id: id,
            plantId: plantId,
            date: date,
            sunlightScore: sunlightScore,
            waterScore: waterScore,
            soilScore: soilScore,
            note: note,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int plantId,
            required String date,
            required double sunlightScore,
            required double waterScore,
            required double soilScore,
            Value<String?> note = const Value.absent(),
            required String createdAt,
          }) =>
              DailyLogTableCompanion.insert(
            id: id,
            plantId: plantId,
            date: date,
            sunlightScore: sunlightScore,
            waterScore: waterScore,
            soilScore: soilScore,
            note: note,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$DailyLogTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({plantId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (plantId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.plantId,
                    referencedTable:
                        $$DailyLogTableTableReferences._plantIdTable(db),
                    referencedColumn:
                        $$DailyLogTableTableReferences._plantIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$DailyLogTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $DailyLogTableTable,
    DailyLogTableData,
    $$DailyLogTableTableFilterComposer,
    $$DailyLogTableTableOrderingComposer,
    $$DailyLogTableTableAnnotationComposer,
    $$DailyLogTableTableCreateCompanionBuilder,
    $$DailyLogTableTableUpdateCompanionBuilder,
    (DailyLogTableData, $$DailyLogTableTableReferences),
    DailyLogTableData,
    PrefetchHooks Function({bool plantId})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PlantTableTableTableManager get plantTable =>
      $$PlantTableTableTableManager(_db, _db.plantTable);
  $$DailyLogTableTableTableManager get dailyLogTable =>
      $$DailyLogTableTableTableManager(_db, _db.dailyLogTable);
}
