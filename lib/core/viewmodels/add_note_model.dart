import 'package:edukasi_pot/core/enums/viewstate.dart';
import 'package:edukasi_pot/core/services/services.dart';
import 'package:edukasi_pot/core/viewmodels/base_model.dart';
import 'package:edukasi_pot/locator.dart';

class AddNoteModel extends BaseModel {
  AuthService _authService = locator<AuthService>();
  NavigationService _navigationService = locator<NavigationService>();

  Future<void> logout() async {
    setState(ViewState.Busy);
    await Future.delayed(Duration(milliseconds: 600));
    _authService.logout();

    setState(ViewState.Idle);
    _navigationService.logout();
  }
}
