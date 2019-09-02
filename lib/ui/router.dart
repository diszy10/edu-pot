import 'package:edukasi_pot/core/constants/route_paths.dart' as routes;
import 'package:edukasi_pot/core/services/api/models.dart';
import 'package:edukasi_pot/ui/views/views.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case routes.Login:
      return PageTransition(
          child: LoginView(), type: PageTransitionType.upToDown);
    case routes.SubjectDetail:
      var subject = settings.arguments as Subject;
      return PageTransition(
          child: SubjectDetailView(subject: subject),
          type: PageTransitionType.rightToLeftWithFade);
    case routes.SubjectList:
      return PageTransition(
          child: SubjectListView(),
          type: PageTransitionType.leftToRightWithFade);
    case routes.ModuleDetail:
      var module = settings.arguments as Module;
      return PageTransition(
          child: ModuleView(module: module), type: PageTransitionType.fade);
    case routes.Homework:
      return PageTransition(
          child: HomeworkView(), type: PageTransitionType.rightToLeftWithFade);
    case routes.Attendance:
      return PageTransition(
          child: AttendanceView(),
          type: PageTransitionType.rightToLeftWithFade);
    case routes.AddNote:
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
