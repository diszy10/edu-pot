import 'package:edukasi_pot/core/services/api/models.dart';

abstract class Api {
  Future<User> getUser(String email, String password);

  Future<List<Subject>> getSubjectsForUser(String userId);

  Future<List<Module>> getModulesForSubject(String subjectId);

  Future<List<Homework>> getHomeworksForSubject(String subjectId);

  Future<List<Student>> getStudentsForSubject(String subjectId);
}
