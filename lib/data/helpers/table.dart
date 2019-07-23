import 'package:sqflite/sqflite.dart';

abstract class Table {
  String get tableName;
  void onCreate(Batch batch, int version);
  void onUpgrade(Batch batch, int oldVersion, int newVersion);
}