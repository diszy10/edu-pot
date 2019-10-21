import 'package:edukasi_pot/core/services/api/api.dart';
import 'package:edukasi_pot/core/services/api/models.dart';

class HttpApi implements Api {
  @override
  Future<List<Homework>> getHomeworksForSubject(int subjectId) {
    return null;
  }

  @override
  Future<List<Module>> getModulesForSubject(int subjectId) {
    return null;
  }

  @override
  Future<List<Student>> getStudentsForSubject(int subjectId) {
    return null;
  }

  @override
  Future<List<Subject>> getSubjectsForUser(int userId) {
    return null;
  }

  @override
  Future<User> getUser(String email, String password) {
    return null;
  }
}
