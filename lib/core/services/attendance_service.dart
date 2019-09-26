import 'package:edukasi_pot/core/services/api/api.dart';
import 'package:edukasi_pot/core/services/api/models.dart';
import 'package:edukasi_pot/core/services/stoppable_service.dart';
import 'package:edukasi_pot/locator.dart';

class AttendanceService implements StoppableService {
  Api _api = locator<Api>();

  List<Student> _students;
  List<Student> get students => _students;

  Future getStudents(String subjectId) async {
    _students = await _api.getStudentsForSubject(subjectId);
  }

  Student getStudent(String studentId) {
    return _students.firstWhere((student) => student.id == studentId);
  }

  void setAbsent(String studentId) {
    _students.firstWhere((student) => student.id == studentId).isAbsent = true;
  }

  void setAttend(String studentId) {
    _students.firstWhere((student) => student.id == studentId).isAbsent = false;
  }

  @override
  bool get serviceStopped => null;

  @override
  void start() {}

  @override
  void stop() {}
}
