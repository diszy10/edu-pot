import 'package:edukasi_pot/core/services/api/models.dart';
import 'package:edukasi_pot/ui/views/views.dart';
import 'package:edukasi_pot/ui/widgets/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Router {
  static String initialRoute = 'login';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'splash':
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case 'login':
        return PageTransition(
            child: LoginView(), type: PageTransitionType.upToDown);
      case 'subject':
        var subject = settings.arguments as Subject;
        return PageTransition(
            child: SubjectDetailView(subject: subject),
            type: PageTransitionType.rightToLeftWithFade);
      case 'subject-list':
        return PageTransition(
            child: SubjectListView(),
            type: PageTransitionType.leftToRightWithFade);
      case 'module-detail':
        var module = settings.arguments as Module;
        return PageTransition(
            child: ModuleView(module: module), type: PageTransitionType.fade);
      case 'homework':
        return PageTransition(
            child: HomeworkView(),
            type: PageTransitionType.rightToLeftWithFade);
      case 'attendance':
        return PageTransition(
            child: AttendanceView(),
            type: PageTransitionType.rightToLeftWithFade);
      case 'add-note':
        return PageTransition(
            child: AddNoteView(), type: PageTransitionType.rightToLeftWithFade);
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
