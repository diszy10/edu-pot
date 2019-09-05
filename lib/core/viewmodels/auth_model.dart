import 'package:edukasi_pot/core/constants/route_paths.dart' as routes;
import 'package:edukasi_pot/core/enums/viewstate.dart';
import 'package:edukasi_pot/core/services/auth_service.dart';
import 'package:edukasi_pot/core/services/navigation_service.dart';
import 'package:edukasi_pot/core/services/subject_service.dart';
import 'package:edukasi_pot/core/viewmodels/base_model.dart';
import 'package:edukasi_pot/locator.dart';

class AuthModel extends BaseModel {
  NavigationService _navigationService = locator<NavigationService>();

  AuthService _authService = locator<AuthService>();

  SubjectService _subjectsService = locator<SubjectService>();

  Future<void> login(String email, String password) async {
    try {
      setState(ViewState.Authenticate);

      /// Login service
      await _authService.authenticate(email, password);

      /// Get subjectInSession
      await _subjectsService.getSubjectInSession();

      setState(ViewState.Busy);
      await Future.delayed(Duration(milliseconds: 600));

      var subjectInSession = _subjectsService.subjectInSession;
      if (subjectInSession != null) {
        _navigationService.navigateToReplacement(routes.SubjectDetail,
            arguments: subjectInSession);
      } else {
        _navigationService.navigateToReplacement(routes.SubjectList);
      }
    } catch (e) {
      setState(ViewState.Idle);
      throw (e);
    }
  }

  Future<void> logout() async {
    setState(ViewState.Busy);
    await Future.delayed(Duration(milliseconds: 600));
    _subjectsService.clearSubjectInSession();

    setState(ViewState.Idle);
    _navigationService.logout();
  }
}
