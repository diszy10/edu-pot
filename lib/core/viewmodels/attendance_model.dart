import 'package:edukasi_pot/core/constants/route_paths.dart' as routes;
import 'package:edukasi_pot/core/enums/viewstate.dart';
import 'package:edukasi_pot/core/services/api/models.dart';
import 'package:edukasi_pot/core/services/attendance_service.dart';
import 'package:edukasi_pot/core/services/navigation_service.dart';
import 'package:edukasi_pot/core/viewmodels/base_model.dart';
import 'package:edukasi_pot/locator.dart';

class AttendanceModel extends BaseModel {
  NavigationService _navigationService = locator<NavigationService>();
  
  AttendanceService _attendancesService = locator<AttendanceService>();

  List<Student> get students => _attendancesService.students;

  Future<void> getStudentsForSubject(String subjectId) async {
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

  void navigateToAddNote() {
    _navigationService.navigateTo(routes.AddNote);
  }

  void navigateBack() {
    _navigationService.navigateBack();
  }
}
