import 'package:edukasi_pot/core/constants/route_paths.dart' as routes;
import 'package:edukasi_pot/core/services/api/models.dart';
import 'package:edukasi_pot/core/services/services.dart';
import 'package:edukasi_pot/locator.dart';
import 'package:edukasi_pot/ui/router.dart' as router;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  SystemChrome.setEnabledSystemUIOverlays([]);

  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<User>.controller(
            builder: (context) => locator<AuthService>().userController),
        StreamProvider<Subject>.controller(
            builder: (context) => locator<SubjectService>().subjectController),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Edukasi POT',
        initialRoute: routes.Login,
        onGenerateRoute: router.generateRoute,
        navigatorKey: locator<NavigationService>().navigatorKey,
      ),
    );
  }
}
