import 'package:edukasi_pot/core/data/tables.dart';
import 'package:edukasi_pot/core/services/stoppable_service.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'database_service.g.dart';

@UseMoor(tables: [Subjects, Homeworks])
class DatabaseService extends _$DatabaseService implements StoppableService {
  DatabaseService()
      : super(FlutterQueryExecutor.inDatabaseFolder(
            path: 'db.sqlite', logStatements: true));

  ///
  /// [Subjects]
  ///
  Future<List<Subject>> getAllSubjects() => select(subjects).get();

  // Auto emit elements when the watched data changes
  Stream<List<Subject>> watchAllSubjects() => select(subjects).watch();

  Future insertSubject(Subject subject) => into(subjects).insert(subject);
  Future updateSubject(Subject subject) => update(subjects).replace(subject);
  Future deleteSubject(Subject subject) => delete(subjects).delete(subject);

  ///
  /// [Homeworks]
  ///
  Future<List<Homework>> getAllHomeworks() => select(homeworks).get();

  // Auto emit elements when the watched data changes
  Stream<List<Homework>> watchAllHomework() => select(homeworks).watch();

  Future insertHomework(Homework homework) => into(homeworks).insert(homework);
  Future updateHomework(Homework homework) =>
      update(homeworks).replace(homework);
  Future deleteHomework(Homework homework) =>
      delete(homeworks).delete(homework);

  @override
  int get schemaVersion => 1;

  @override
  bool get serviceStopped => null;

  @override
  void start() {}

  @override
  void stop() {}
}
