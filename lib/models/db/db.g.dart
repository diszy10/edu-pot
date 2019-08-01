// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps
class Subject extends DataClass implements Insertable<Subject> {
  final int id;
  final String klass;
  final String name;
  final DateTime startTime;
  final DateTime endTime;
  Subject(
      {@required this.id,
      @required this.klass,
      @required this.name,
      @required this.startTime,
      @required this.endTime});
  factory Subject.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return Subject(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      klass:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}klass']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      startTime: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}start_time']),
      endTime: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}end_time']),
    );
  }
  factory Subject.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return Subject(
      id: serializer.fromJson<int>(json['id']),
      klass: serializer.fromJson<String>(json['klass']),
      name: serializer.fromJson<String>(json['name']),
      startTime: serializer.fromJson<DateTime>(json['startTime']),
      endTime: serializer.fromJson<DateTime>(json['endTime']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<int>(id),
      'klass': serializer.toJson<String>(klass),
      'name': serializer.toJson<String>(name),
      'startTime': serializer.toJson<DateTime>(startTime),
      'endTime': serializer.toJson<DateTime>(endTime),
    };
  }

  @override
  T createCompanion<T extends UpdateCompanion<Subject>>(bool nullToAbsent) {
    return SubjectsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      klass:
          klass == null && nullToAbsent ? const Value.absent() : Value(klass),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      startTime: startTime == null && nullToAbsent
          ? const Value.absent()
          : Value(startTime),
      endTime: endTime == null && nullToAbsent
          ? const Value.absent()
          : Value(endTime),
    ) as T;
  }

  Subject copyWith(
          {int id,
          String klass,
          String name,
          DateTime startTime,
          DateTime endTime}) =>
      Subject(
        id: id ?? this.id,
        klass: klass ?? this.klass,
        name: name ?? this.name,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
      );
  @override
  String toString() {
    return (StringBuffer('Subject(')
          ..write('id: $id, ')
          ..write('klass: $klass, ')
          ..write('name: $name, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      $mrjc($mrjc($mrjc($mrjc(0, id.hashCode), klass.hashCode), name.hashCode),
          startTime.hashCode),
      endTime.hashCode));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is Subject &&
          other.id == id &&
          other.klass == klass &&
          other.name == name &&
          other.startTime == startTime &&
          other.endTime == endTime);
}

class SubjectsCompanion extends UpdateCompanion<Subject> {
  final Value<int> id;
  final Value<String> klass;
  final Value<String> name;
  final Value<DateTime> startTime;
  final Value<DateTime> endTime;
  const SubjectsCompanion({
    this.id = const Value.absent(),
    this.klass = const Value.absent(),
    this.name = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
  });
}

class $SubjectsTable extends Subjects with TableInfo<$SubjectsTable, Subject> {
  final GeneratedDatabase _db;
  final String _alias;
  $SubjectsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        $customConstraints: 'UNIQUE');
  }

  final VerificationMeta _klassMeta = const VerificationMeta('klass');
  GeneratedTextColumn _klass;
  @override
  GeneratedTextColumn get klass => _klass ??= _constructKlass();
  GeneratedTextColumn _constructKlass() {
    return GeneratedTextColumn(
      'klass',
      $tableName,
      false,
    );
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _startTimeMeta = const VerificationMeta('startTime');
  GeneratedDateTimeColumn _startTime;
  @override
  GeneratedDateTimeColumn get startTime => _startTime ??= _constructStartTime();
  GeneratedDateTimeColumn _constructStartTime() {
    return GeneratedDateTimeColumn(
      'start_time',
      $tableName,
      false,
    );
  }

  final VerificationMeta _endTimeMeta = const VerificationMeta('endTime');
  GeneratedDateTimeColumn _endTime;
  @override
  GeneratedDateTimeColumn get endTime => _endTime ??= _constructEndTime();
  GeneratedDateTimeColumn _constructEndTime() {
    return GeneratedDateTimeColumn(
      'end_time',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, klass, name, startTime, endTime];
  @override
  $SubjectsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'subjects';
  @override
  final String actualTableName = 'subjects';
  @override
  VerificationContext validateIntegrity(SubjectsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.klass.present) {
      context.handle(
          _klassMeta, klass.isAcceptableValue(d.klass.value, _klassMeta));
    } else if (klass.isRequired && isInserting) {
      context.missing(_klassMeta);
    }
    if (d.name.present) {
      context.handle(
          _nameMeta, name.isAcceptableValue(d.name.value, _nameMeta));
    } else if (name.isRequired && isInserting) {
      context.missing(_nameMeta);
    }
    if (d.startTime.present) {
      context.handle(_startTimeMeta,
          startTime.isAcceptableValue(d.startTime.value, _startTimeMeta));
    } else if (startTime.isRequired && isInserting) {
      context.missing(_startTimeMeta);
    }
    if (d.endTime.present) {
      context.handle(_endTimeMeta,
          endTime.isAcceptableValue(d.endTime.value, _endTimeMeta));
    } else if (endTime.isRequired && isInserting) {
      context.missing(_endTimeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  Subject map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Subject.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(SubjectsCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.klass.present) {
      map['klass'] = Variable<String, StringType>(d.klass.value);
    }
    if (d.name.present) {
      map['name'] = Variable<String, StringType>(d.name.value);
    }
    if (d.startTime.present) {
      map['start_time'] = Variable<DateTime, DateTimeType>(d.startTime.value);
    }
    if (d.endTime.present) {
      map['end_time'] = Variable<DateTime, DateTimeType>(d.endTime.value);
    }
    return map;
  }

  @override
  $SubjectsTable createAlias(String alias) {
    return $SubjectsTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(const SqlTypeSystem.withDefaults(), e);
  $SubjectsTable _subjects;
  $SubjectsTable get subjects => _subjects ??= $SubjectsTable(this);
  SubjectsDao _subjectsDao;
  SubjectsDao get subjectsDao =>
      _subjectsDao ??= SubjectsDao(this as AppDatabase);
  @override
  List<TableInfo> get allTables => [subjects];
}
