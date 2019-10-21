import 'package:edukasi_pot/core/services/api/api.dart';
import 'package:edukasi_pot/core/services/database_service.dart';
import 'package:edukasi_pot/locator.dart';

///
/// [Data access layer for handle data persistence]
/// [This repository will handle all data from api network]
/// [and local database using sqflite to cache data.]
///

class Repository {
  // Api
  Api _api = locator<Api>();

  // Database
  DatabaseService _db = locator<DatabaseService>();

  ///
  /// [Store list of subjects from api network to local database]
  ///
  Future getSubjects(int userId) async {
    ///
    /// [Check if subjects data is also exists in the local storage,]
    /// [that version of subjects will be used instead.]
    ///

    List<Subject> subjectsFromDb = await _db.getAllSubjects();

    if (subjectsFromDb == null) {
      print('Subjects in database is not available');
    }

    if (subjectsFromDb != null) {
      // final subjectsDataFromDb = subjectsFromDb.toList();
      // List<model.Subject> finalData = [];
      // subjectsDataFromDb.forEach((s) async {
      //   List<model.Subject> response = await _api.getSubjectsForUser(userId);
      //   response.forEach((s) {
      //     final subject = Subject(
      //       id: s.id,
      //       title: s.title,
      //       klass: s.klass,
      //       startTime: s.startTime,
      //       endTime: s.endTime,
      //     );
      //     _db.updateSubject(subject);
      //   });

      //   final subject = model.Subject(
      //     id: s.id,
      //     title: s.title,
      //     klass: s.klass,
      //     startTime: s.startTime,
      //     endTime: s.endTime,
      //   );
      //   finalData.add(subject);
      // });

      return await _api.getSubjectsForUser(userId);
    }
  }

  ///
  /// [Store list of modules from api network to local database]
  ///
  Future getModules(int subjectId) async {
    return await _api.getModulesForSubject(subjectId);
  }

  ///
  /// [Store list of homeworks from api network to local database]
  ///
  Future getHomeworks(int subjectId) async {
    return await _api.getHomeworksForSubject(subjectId);
  }

  ///
  /// [Store list of students from api network to local database]
  ///
  Future getStudents(int subjectId) async {
    return await _api.getStudentsForSubject(subjectId);
  }
}
