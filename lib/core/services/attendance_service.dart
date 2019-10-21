import 'package:edukasi_pot/core/data/repository.dart';
import 'package:edukasi_pot/core/services/api/models.dart';
import 'package:edukasi_pot/core/services/stoppable_service.dart';
import 'package:edukasi_pot/locator.dart';

class AttendanceService implements StoppableService {
  Repository _repo = locator<Repository>();

  List<Student> _students;
  List<Student> get students => _students;

  Future getStudents(int subjectId) async {
    _students = await _repo.getStudents(subjectId);
  }

  Student getStudent(int studentId) {
    return _students.firstWhere((student) => student.id == studentId);
  }

  void setAbsent(int studentId) {
    _students.firstWhere((student) => student.id == studentId).isAbsent = true;
  }

  void setAttend(int studentId) {
    _students.firstWhere((student) => student.id == studentId).isAbsent = false;
  }

  @override
  bool get serviceStopped => null;

  @override
  void start() {}

  @override
  void stop() {}
}
