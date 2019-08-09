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
        assert(args.data is List<Subject>);
        var subjListArgs = args as SubjectListArgument;

        var screen = SubjectListScreen(
          subjectList: args.data as List<Subject>,
          subjectSelected: subjListArgs.subject,
        );

        if (args.from == SubjectScreen.routeName) {
          return FadePageRoute(widget: _AuthWidget(screen));
        }
        return _buildRoute(screen);
      case SubjectScreen.routeName:
        assert(args.data is Subject);

        var screen = SubjectScreen(subject: args.data as Subject);
        if (args.from == SubjectListScreen.routeName) {
          return FadePageRoute(widget: _AuthWidget(screen));
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
    return MaterialPageRoute(builder: (context) => _AuthWidget(screen));
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
class _AuthWidget extends StatefulWidget {
  final Widget _screen;

  _AuthWidget(this._screen);

  @override
  _AuthWidgetState createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<_AuthWidget> {
  bool _isAuth;

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
        builder: (context, authProv, child) {
          if (_isAuth == null) {
            authProv.isUserAuth.then((value) => _isAuth = value);
          } else {
            authProv.isUserAuth.then((value) {
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
        child: widget._screen);
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
      Navigator.of(context).pushReplacementNamed(SubjectListScreen.routeName,
          arguments: SubjectListArgument(data: _list));
    } else {
      Navigator.of(context).pushReplacementNamed(SubjectScreen.routeName,
          arguments: RouteArgument(data: _subject));
    }
  }
}
