import 'package:moor_flutter/moor_flutter.dart';

class Subjects extends Table {
  IntColumn get id => integer().customConstraint('UNIQUE')();
  TextColumn get klass => text()();
  TextColumn get name => text()();
  DateTimeColumn get startTime => dateTime()();
  DateTimeColumn get endTime => dateTime()();
}

class UtcSerializer extends ValueSerializer {
  @override
  T fromJson<T>(json) {
    if (T == DateTime) {
      return DateTime.parse(json as String) as T;
    } 
    return json;
  }

  @override
  toJson<T>(T value) {
    if (T.runtimeType == DateTime) {
      return (value as DateTime).toIso8601String();
    }
    return value;
  }
}