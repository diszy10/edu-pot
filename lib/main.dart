import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

import 'package:edukasi_pot/config/config.dart';
import 'package:edukasi_pot/helpers/helpers.dart';
import 'package:edukasi_pot/models/models.dart';
import 'package:edukasi_pot/providers/providers.dart';
import 'package:edukasi_pot/router.dart';

void baseMain() {
  // Initialize singleton
  AppDatabase _db = AppDatabase();
  Api _api = Api();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(MultiProvider(providers: [
    Provider<Api>.value(value: _api),
    Provider<AppDatabase>.value(value: _db),
    ChangeNotifierProvider<AuthProvider>(
      builder: (context) => AuthProvider(_api),
    ),
    ChangeNotifierProvider<SubjectProvider>(
      builder: (context) => SubjectProvider(_db, _api),
    )
  ], child: _MainApp()));
}

class _MainApp extends StatelessWidget {
  const _MainApp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Config().getString(Config.appName),
      onGenerateRoute: AppRouter.generateRoute,
      theme: ThemeData(
        primaryColor: Color(0xFF5B6CEC),
        scaffoldBackgroundColor: Color(0xFFF9F6F5),
      ),
    );
  }
}
