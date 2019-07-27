import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:edukasi_pot/helpers/helpers.dart';
import 'package:edukasi_pot/models/data/data.dart';

final List<Table> tables = [School()];

class AppDatabase {
  static final AppDatabase _instance = AppDatabase._internal();

  // Factory Constructor
  factory AppDatabase() => _instance;

  // Private Constructor
  AppDatabase._internal();

  // Database Instance
  static Database _db;

  /// Database version
  ///
  /// Version should always be incremented everytime the database's table changed.
  static const _version = 1;
  static const _dbName = 'edukasi_pot.db';

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await _initDb();
    return _db;
  }

  _initDb() async {
    var dbPath = await getDatabasesPath();
    var fullPath = join(dbPath, _dbName);
    // NOTE: Might have risk of race condition.
    // https://github.com/tekartik/sqflite/blob/master/sqflite/doc/opening_db.md
    return await openDatabase(fullPath, version: _version, onConfigure: _onConfigure, onCreate: _onCreate, onUpgrade: _onUpgrade);
  }

  void _onConfigure(Database db) async {
    // SQLite >= 3.6.12
    await db.execute('PRAGMA foreign_keys = ON');
  }

  void _onCreate(Database db, int version) async {
    var batch = db.batch();
    for (var table in tables) {
      table.onCreate(batch, version);
    }
    await batch.commit(noResult: true);
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) async {
    var batch = db.batch();
    for (var table in tables) {
      table.onUpgrade(batch, oldVersion, newVersion);
    }
    await batch.commit(noResult: true);
  }
}