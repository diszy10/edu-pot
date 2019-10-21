import 'package:moor/moor.dart';
import 'package:moor_flutter/moor_flutter.dart';

// @DataClassName('Subj')
class Subjects extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1, max: 50)();
  TextColumn get klass => text().withLength(min: 1, max: 50)();
  DateTimeColumn get startTime => dateTime().nullable()();
  DateTimeColumn get endTime => dateTime().nullable()();

  // @override
  // Set<Column> get primaryKey => {id, title};
}

class Homeworks extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1, max: 150)();
  DateTimeColumn get deadline => dateTime().nullable()();
  TextColumn get color => text()();
}
