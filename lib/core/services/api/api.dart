import 'package:edukasi_pot/core/services/api/models.dart';

abstract class Api {
  Future<User> getUser(String email, String password);

  Future<List<Subject>> getSubjectsForUser(int userId);

  Future<List<Module>> getModulesForSubject(int subjectId);

  Future<List<Homework>> getHomeworksForSubject(int subjectId);

  Future<List<Student>> getStudentsForSubject(int subjectId);
}
