import 'package:edukasi_pot/core/services/api/api.dart';
import 'package:edukasi_pot/core/services/api/models.dart';

class HttpApi implements Api {
  @override
  Future<List<Homework>> getHomeworksForSubject(String subjectId) {
    return null;
  }

  @override
  Future<List<Module>> getModulesForSubject(String topicId) {
    return null;
  }

  @override
  Future<List<Student>> getStudentsForSubject(String subjectId) {
    return null;
  }

  @override
  Future<List<Subject>> getSubjectsForUser(String userId) {
    return null;
  }

  @override
  Future<User> getUser(String email, String password) {
    return null;
  }
}
