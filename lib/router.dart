import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:edukasi_pot/screens/screens.dart';
import 'package:edukasi_pot/providers/providers.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Argumenst when calling with pushNamed
    // final args = settings.arguments;
    switch (settings.name) {
      case AuthScreen.routeName:
        return _buildRoute(AuthScreen());
      case SplashScreen.routeName:
        return _buildRoute(SplashScreen());
      case LoginScreen.routeName:
        return _buildRoute(LoginScreen());
      case SubjectListScreen.routeName:
        return _buildRoute(SubjectListScreen());
      case SubjectScreen.routeName:
        return _buildRoute(SubjectScreen());
      case ModuleScreen.routeName:
        return _buildRoute(ModuleScreen());
      case HomeworkScreen.routeName:
        return _buildRoute(HomeworkScreen());
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
                Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
              } else if (value == true) {
                Navigator.of(context).pushReplacementNamed(SubjectListScreen.routeName);
              }
            }
          });
        }
        return child;
      },
      child: _screen);
  }
}
