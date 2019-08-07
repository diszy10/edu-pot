import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:edukasi_pot/models/models.dart';
import 'package:edukasi_pot/providers/providers.dart';
import 'package:edukasi_pot/screens/screens.dart';
import 'package:edukasi_pot/widgets/widgets.dart';


class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Argumenst when calling with pushNamed
    var args = settings.arguments as RouteArgument;

    switch (settings.name) {
      case AuthScreen.routeName:
        return _buildRoute(AuthScreen());
      case SplashScreen.routeName:
        return _buildRoute(SplashScreen());
      case LoginScreen.routeName:
        return _buildRoute(LoginScreen());
      case SubjectListScreen.routeName:
        assert(args.obj is List<Subject>);

        var screen = SubjectListScreen(subjectList: args.obj as List<Subject>);
        if (args.from == SubjectScreen.routeName) {
          return FadePageRoute(widget: _HigherOrderWidget(screen));
        }
        return _buildRoute(screen);
      case SubjectScreen.routeName:
        assert(args.obj is Subject);

        var screen = SubjectScreen(subject: args.obj as Subject);
        if (args.from == SubjectListScreen.routeName) {
          return FadePageRoute(widget: _HigherOrderWidget(screen));
        }
        return _buildRoute(screen);
      case ModuleScreen.routeName:
        return _buildRoute(ModuleScreen());
      case HomeworkScreen.routeName:
        return _buildRoute(HomeworkScreen());
      case AttendanceScreen.routeName:
        return _buildRoute(AttendanceScreen());
      case NoteScreen.routeName:
        return _buildRoute(NoteScreen());
      default:
        return _errorRoute(settings.name);
    }
  }

  static MaterialPageRoute<dynamic> _buildRoute<T extends Widget>(T screen) {
    return MaterialPageRoute(builder: (context) => _HigherOrderWidget(screen));
  }

  static Route<dynamic> _errorRoute(String name) {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        body: Center(
          child: Text(
            'No route defined for $name',
            style: TextStyle(fontSize: 28),
          ),
        ),
      );
    });
  }
}

/// Higher Order Widget with authenticated state.
///
/// This widget hold the authenticated state the entire applications
/// If authenticated state change, then it will push to a new route accordingly
class _HigherOrderWidget extends StatelessWidget {
  final Widget _screen;
  bool _isAuth;

  _HigherOrderWidget(this._screen);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
        builder: (context, value, child) {
          if (_isAuth == null) {
            value.isUserAuth.then((value) => _isAuth = value);
          } else {
            value.isUserAuth.then((value) {
              if (_isAuth != value) {
                if (value == false) {
                  _onSuccessLogout(context);
                } else if (value == true) {
                  _onSuccessLogin(context);
                }
              }
            });
          }
          return child;
        },
        child: _screen);
  }

  _onSuccessLogout(BuildContext context) async {
    await Provider.of<SubjectProvider>(context).onLogout();
    Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
  }

  _onSuccessLogin(BuildContext context) async {
    var _subProv = Provider.of<SubjectProvider>(context, listen: false);
    var _subject = await _subProv.subjectInSession;
    if (_subject == null) {
      var _list = await _subProv.subjectList;
      Navigator.of(context).pushReplacementNamed(SubjectListScreen.routeName, arguments: RouteArgument(obj: _list));
    } else {
      Navigator.of(context).pushReplacementNamed(SubjectScreen.routeName, arguments: RouteArgument(obj: _subject));
    }
  }
}
