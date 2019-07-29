import 'package:sqflite/sqlite_api.dart';

import 'package:edukasi_pot/helpers/helpers.dart';

class SubjectData implements Table {
  // Table
  static const String colId = '_id';
  static const String colIdServer = 'id_server';
  static const String colName = 'name';
  static const String colKlass = 'klass';
  static const String colStartTime = 'start_time';
  static const String colEndTime = 'end_time';

  @override
  static String tableName = 'subject';

  @override
  void onCreate(Batch batch, int version) {
    batch.execute('''CREATE TABLE IF NOT EXISTS $tableName(
      $colId INTEGER PRIMARY KEY,
      $colIdServer INTEGER NOT NULL UNIQUE,
      $colName TEXT NOT NULL,
      $colKlass TEXT NOT NULL,
      $colStartTime TEXT NOT NULL,
      $colEndTime TEXT NOT NULL,
    )''');
  }

  @override
  void onUpgrade(Batch batch, int oldVersion, int newVersion) {
  }
}