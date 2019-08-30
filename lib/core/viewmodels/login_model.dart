import 'package:edukasi_pot/core/enums/viewstate.dart';
import 'package:edukasi_pot/core/services/auth_service.dart';
import 'package:edukasi_pot/core/services/subject_service.dart';
import 'package:edukasi_pot/core/viewmodels/base_model.dart';
import 'package:edukasi_pot/locator.dart';
import 'package:flutter/material.dart';

class LoginModel extends BaseModel {
  AuthService _authService = locator<AuthService>();

  SubjectService _subjectsService = locator<SubjectService>();

  Future<void> login(
      BuildContext context, String email, String password) async {
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
        Navigator.pushReplacementNamed(context, 'subject',
            arguments: subjectInSession);
      } else {
        Navigator.pushReplacementNamed(context, 'subject-list');
      }
    } catch (e) {
      setState(ViewState.Idle);
      throw (e);
    }
  }

  Future<void> logout(BuildContext context) async {
    try {
      Navigator.of(context)
          .pushNamedAndRemoveUntil('login', (Route<dynamic> route) => false);
    } catch (e) {
      throw (e);
    }
  }
}
