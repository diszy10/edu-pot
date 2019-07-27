import 'package:sqflite/sqlite_api.dart';

import 'package:edukasi_pot/helpers/helpers.dart';

class School extends Table {
  static const columnId = '_id';
  static const columnName = 'name';

  @override
  String get tableName => 'school';

  @override
  void onCreate(Batch batch, int version) {
    batch.execute('''CREATE TABLE $tableName(
      $columnId INTEGER PRIMARY KEY,
      $columnName TEXT,
    )''');
  }

  @override
  void onUpgrade(Batch batch, int oldVersion, int newVersion) {
    // TODO: implement onUpgrade
  }

  
}