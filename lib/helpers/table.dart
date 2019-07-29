import 'package:sqflite/sqflite.dart';

abstract class Table {
  static String tableName;
  void onCreate(Batch batch, int version);
  void onUpgrade(Batch batch, int oldVersion, int newVersion);
}