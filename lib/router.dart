import 'package:flutter/material.dart';

import 'package:edukasi_pot/models/models.dart';
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
          return FadePageRoute(widget: screen);
        }
        return _buildRoute(screen);
      case SubjectScreen.routeName:
        assert(args.data is Subject);

        var screen = SubjectScreen(subject: args.data as Subject);
        if (args.from == SubjectListScreen.routeName) {
          return FadePageRoute(widget: screen);
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
    return MaterialPageRoute(builder: (context) => screen);
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
