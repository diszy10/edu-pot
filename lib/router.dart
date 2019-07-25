import 'package:flutter/material.dart';

import 'package:edukasi_pot/screens/screens.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Argumenst when calling with pushNamed
    final args = settings.arguments;
    switch (settings.name) {
      case AuthScreen.routeName:
        return MaterialPageRoute(builder: (_) => AuthScreen());
      case SplashScreen.routeName:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case LoginScreen.routeName:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case SchoolScreen.routeName:
        return MaterialPageRoute(builder: (_) => SchoolScreen());
      case SubjectScreen.routeName:
        return MaterialPageRoute(builder: (_) => SubjectScreen());
      case SubjectAuthScreen.routeName:
        return MaterialPageRoute(builder: (_) => SubjectAuthScreen());
      case HomeworkScreen.routeName:
        return MaterialPageRoute(builder: (_) => HomeworkScreen());
      default:
        return _errorRoute(settings.name);
    }
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
