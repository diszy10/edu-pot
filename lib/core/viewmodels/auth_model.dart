import 'package:edukasi_pot/core/constants/route_paths.dart' as routes;
import 'package:edukasi_pot/core/enums/viewstate.dart';
import 'package:edukasi_pot/core/services/api/models.dart';
import 'package:edukasi_pot/core/services/auth_service.dart';
import 'package:edukasi_pot/core/services/localstorage_service.dart';
import 'package:edukasi_pot/core/services/navigation_service.dart';
import 'package:edukasi_pot/core/services/subject_service.dart';
import 'package:edukasi_pot/core/viewmodels/base_model.dart';
import 'package:edukasi_pot/locator.dart';

class AuthModel extends BaseModel {
  NavigationService _navigationService = locator<NavigationService>();

  AuthService _authService = locator<AuthService>();
  SubjectService _subjectsService = locator<SubjectService>();

  bool get isAuth => _authService.isAuth;
  Subject get subjectInSession => _subjectsService.subjectInSession;

  Future<void> login(String email, String password) async {
    try {
      setState(ViewState.Authenticate);

      /// Login service
      await _authService.authenticate(email, password);

      /// Get subjectInSession
      await _subjectsService.getSubjectInSession();

      setState(ViewState.Busy);
      await Future.delayed(Duration(milliseconds: 600));

      if (_isEmailSaved == true) {
        _localStorageService.email = email;
      }

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

  Future<void> tryAutoLogin() async {
    await _authService.tryAutoLogin();
  }

  Future<void> logout() async {
    setState(ViewState.Busy);
    await Future.delayed(Duration(milliseconds: 600));
    _authService.logout();

    setState(ViewState.Idle);
    _navigationService.logout();
  }


  LocalStorageService _localStorageService = locator<LocalStorageService>();

  get email => _localStorageService.email;

  bool _isEmailSaved = false;
  get isEmailSaved => _isEmailSaved;
  
  void setRememberEmail(bool value) {
    _isEmailSaved = value;
  }

  void removeSavedEmail() {
    _localStorageService.removeEmail();
    notifyListeners();
  }
}
