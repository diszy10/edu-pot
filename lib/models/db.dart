import 'package:moor_flutter/moor_flutter.dart';

import 'package:edukasi_pot/models/dao/dao.dart';
import 'package:edukasi_pot/models/models.dart';

part 'db.g.dart';

@UseMoor(tables: [Subjects], daos: [SubjectsDao])
class AppDatabase extends _$AppDatabase {
  static final AppDatabase _instance = AppDatabase._internal();

  // Factory Constructor
  factory AppDatabase() => _instance;

  // Private Constructor
  AppDatabase._internal()
      : super(FlutterQueryExecutor.inDatabaseFolder(path: _dbName));

  /// Database version
  ///
  /// Version should always be incremented everytime the database's table changed.
  @override
  int get schemaVersion => 1;

  /// Database file name
  static const _dbName = 'edukasi_pot.db';

  @override
  MigrationStrategy get migration =>
      MigrationStrategy(onCreate: (Migrator m) => m.createAllTables());
}
