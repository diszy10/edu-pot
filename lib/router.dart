import 'package:edukasi_pot/screens/homeworks.dart';
import 'package:edukasi_pot/screens/home.dart';
import 'package:edukasi_pot/screens/login.dart';
import 'package:edukasi_pot/screens/splash.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Argumenst when calling with pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case SplashScreen.routeName:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case HomeScreen.routeName:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case LoginScreen.routeName:
        return MaterialPageRoute(builder: (_) => LoginScreen());
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
