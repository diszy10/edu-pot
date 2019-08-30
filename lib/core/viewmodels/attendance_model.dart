import 'package:edukasi_pot/core/enums/viewstate.dart';
import 'package:edukasi_pot/core/services/api/models.dart';
import 'package:edukasi_pot/core/services/attendance_service.dart';
import 'package:edukasi_pot/core/viewmodels/base_model.dart';
import 'package:edukasi_pot/locator.dart';

class AttendanceModel extends BaseModel {
  AttendanceService _attendancesService = locator<AttendanceService>();

  List<Student> get students => _attendancesService.students;

  Future getStudentsForSubject(String subjectId) async {
    setState(ViewState.Busy);
    await _attendancesService.getStudents(subjectId);
    setState(ViewState.Idle);
  }

  void toggleAbsent(String studentId) {
    _attendancesService.setAbsent(studentId);
    notifyListeners();
  }

  void toggleAttend(String studentId) {
    _attendancesService.setAttend(studentId);
    notifyListeners();
  }
}
