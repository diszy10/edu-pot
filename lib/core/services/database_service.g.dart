// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database_service.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps
class Subject extends DataClass implements Insertable<Subject> {
  final int id;
  final String title;
  final String klass;
  final DateTime startTime;
  final DateTime endTime;
  Subject(
      {@required this.id,
      @required this.title,
      @required this.klass,
      this.startTime,
      this.endTime});
  factory Subject.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return Subject(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      title:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}title']),
      klass:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}klass']),
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
      title: serializer.fromJson<String>(json['title']),
      klass: serializer.fromJson<String>(json['klass']),
      startTime: serializer.fromJson<DateTime>(json['startTime']),
      endTime: serializer.fromJson<DateTime>(json['endTime']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'klass': serializer.toJson<String>(klass),
      'startTime': serializer.toJson<DateTime>(startTime),
      'endTime': serializer.toJson<DateTime>(endTime),
    };
  }

  @override
  T createCompanion<T extends UpdateCompanion<Subject>>(bool nullToAbsent) {
    return SubjectsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      klass:
          klass == null && nullToAbsent ? const Value.absent() : Value(klass),
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
          String title,
          String klass,
          DateTime startTime,
          DateTime endTime}) =>
      Subject(
        id: id ?? this.id,
        title: title ?? this.title,
        klass: klass ?? this.klass,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
      );
  @override
  String toString() {
    return (StringBuffer('Subject(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('klass: $klass, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(title.hashCode,
          $mrjc(klass.hashCode, $mrjc(startTime.hashCode, endTime.hashCode)))));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is Subject &&
          other.id == id &&
          other.title == title &&
          other.klass == klass &&
          other.startTime == startTime &&
          other.endTime == endTime);
}

class SubjectsCompanion extends UpdateCompanion<Subject> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> klass;
  final Value<DateTime> startTime;
  final Value<DateTime> endTime;
  const SubjectsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.klass = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
  });
  SubjectsCompanion copyWith(
      {Value<int> id,
      Value<String> title,
      Value<String> klass,
      Value<DateTime> startTime,
      Value<DateTime> endTime}) {
    return SubjectsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      klass: klass ?? this.klass,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
    );
  }
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
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _titleMeta = const VerificationMeta('title');
  GeneratedTextColumn _title;
  @override
  GeneratedTextColumn get title => _title ??= _constructTitle();
  GeneratedTextColumn _constructTitle() {
    return GeneratedTextColumn('title', $tableName, false,
        minTextLength: 1, maxTextLength: 50);
  }

  final VerificationMeta _klassMeta = const VerificationMeta('klass');
  GeneratedTextColumn _klass;
  @override
  GeneratedTextColumn get klass => _klass ??= _constructKlass();
  GeneratedTextColumn _constructKlass() {
    return GeneratedTextColumn('klass', $tableName, false,
        minTextLength: 1, maxTextLength: 50);
  }

  final VerificationMeta _startTimeMeta = const VerificationMeta('startTime');
  GeneratedDateTimeColumn _startTime;
  @override
  GeneratedDateTimeColumn get startTime => _startTime ??= _constructStartTime();
  GeneratedDateTimeColumn _constructStartTime() {
    return GeneratedDateTimeColumn(
      'start_time',
      $tableName,
      true,
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
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, title, klass, startTime, endTime];
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
    if (d.title.present) {
      context.handle(
          _titleMeta, title.isAcceptableValue(d.title.value, _titleMeta));
    } else if (title.isRequired && isInserting) {
      context.missing(_titleMeta);
    }
    if (d.klass.present) {
      context.handle(
          _klassMeta, klass.isAcceptableValue(d.klass.value, _klassMeta));
    } else if (klass.isRequired && isInserting) {
      context.missing(_klassMeta);
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
  Set<GeneratedColumn> get $primaryKey => {id};
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
    if (d.title.present) {
      map['title'] = Variable<String, StringType>(d.title.value);
    }
    if (d.klass.present) {
      map['klass'] = Variable<String, StringType>(d.klass.value);
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

class Homework extends DataClass implements Insertable<Homework> {
  final int id;
  final String title;
  final DateTime deadline;
  final String color;
  Homework(
      {@required this.id,
      @required this.title,
      this.deadline,
      @required this.color});
  factory Homework.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return Homework(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      title:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}title']),
      deadline: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}deadline']),
      color:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}color']),
    );
  }
  factory Homework.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return Homework(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      deadline: serializer.fromJson<DateTime>(json['deadline']),
      color: serializer.fromJson<String>(json['color']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'deadline': serializer.toJson<DateTime>(deadline),
      'color': serializer.toJson<String>(color),
    };
  }

  @override
  T createCompanion<T extends UpdateCompanion<Homework>>(bool nullToAbsent) {
    return HomeworksCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      deadline: deadline == null && nullToAbsent
          ? const Value.absent()
          : Value(deadline),
      color:
          color == null && nullToAbsent ? const Value.absent() : Value(color),
    ) as T;
  }

  Homework copyWith({int id, String title, DateTime deadline, String color}) =>
      Homework(
        id: id ?? this.id,
        title: title ?? this.title,
        deadline: deadline ?? this.deadline,
        color: color ?? this.color,
      );
  @override
  String toString() {
    return (StringBuffer('Homework(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('deadline: $deadline, ')
          ..write('color: $color')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode,
      $mrjc(title.hashCode, $mrjc(deadline.hashCode, color.hashCode))));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is Homework &&
          other.id == id &&
          other.title == title &&
          other.deadline == deadline &&
          other.color == color);
}

class HomeworksCompanion extends UpdateCompanion<Homework> {
  final Value<int> id;
  final Value<String> title;
  final Value<DateTime> deadline;
  final Value<String> color;
  const HomeworksCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.deadline = const Value.absent(),
    this.color = const Value.absent(),
  });
  HomeworksCompanion copyWith(
      {Value<int> id,
      Value<String> title,
      Value<DateTime> deadline,
      Value<String> color}) {
    return HomeworksCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      deadline: deadline ?? this.deadline,
      color: color ?? this.color,
    );
  }
}

class $HomeworksTable extends Homeworks
    with TableInfo<$HomeworksTable, Homework> {
  final GeneratedDatabase _db;
  final String _alias;
  $HomeworksTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _titleMeta = const VerificationMeta('title');
  GeneratedTextColumn _title;
  @override
  GeneratedTextColumn get title => _title ??= _constructTitle();
  GeneratedTextColumn _constructTitle() {
    return GeneratedTextColumn('title', $tableName, false,
        minTextLength: 1, maxTextLength: 150);
  }

  final VerificationMeta _deadlineMeta = const VerificationMeta('deadline');
  GeneratedDateTimeColumn _deadline;
  @override
  GeneratedDateTimeColumn get deadline => _deadline ??= _constructDeadline();
  GeneratedDateTimeColumn _constructDeadline() {
    return GeneratedDateTimeColumn(
      'deadline',
      $tableName,
      true,
    );
  }

  final VerificationMeta _colorMeta = const VerificationMeta('color');
  GeneratedTextColumn _color;
  @override
  GeneratedTextColumn get color => _color ??= _constructColor();
  GeneratedTextColumn _constructColor() {
    return GeneratedTextColumn(
      'color',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, title, deadline, color];
  @override
  $HomeworksTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'homeworks';
  @override
  final String actualTableName = 'homeworks';
  @override
  VerificationContext validateIntegrity(HomeworksCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.title.present) {
      context.handle(
          _titleMeta, title.isAcceptableValue(d.title.value, _titleMeta));
    } else if (title.isRequired && isInserting) {
      context.missing(_titleMeta);
    }
    if (d.deadline.present) {
      context.handle(_deadlineMeta,
          deadline.isAcceptableValue(d.deadline.value, _deadlineMeta));
    } else if (deadline.isRequired && isInserting) {
      context.missing(_deadlineMeta);
    }
    if (d.color.present) {
      context.handle(
          _colorMeta, color.isAcceptableValue(d.color.value, _colorMeta));
    } else if (color.isRequired && isInserting) {
      context.missing(_colorMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Homework map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Homework.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(HomeworksCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.title.present) {
      map['title'] = Variable<String, StringType>(d.title.value);
    }
    if (d.deadline.present) {
      map['deadline'] = Variable<DateTime, DateTimeType>(d.deadline.value);
    }
    if (d.color.present) {
      map['color'] = Variable<String, StringType>(d.color.value);
    }
    return map;
  }

  @override
  $HomeworksTable createAlias(String alias) {
    return $HomeworksTable(_db, alias);
  }
}

abstract class _$DatabaseService extends GeneratedDatabase {
  _$DatabaseService(QueryExecutor e)
      : super(const SqlTypeSystem.withDefaults(), e);
  $SubjectsTable _subjects;
  $SubjectsTable get subjects => _subjects ??= $SubjectsTable(this);
  $HomeworksTable _homeworks;
  $HomeworksTable get homeworks => _homeworks ??= $HomeworksTable(this);
  @override
  List<TableInfo> get allTables => [subjects, homeworks];
}
