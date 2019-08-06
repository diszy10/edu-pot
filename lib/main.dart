import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

import 'package:edukasi_pot/config/config.dart';
import 'package:edukasi_pot/helpers/helpers.dart';
import 'package:edukasi_pot/models/models.dart';
import 'package:edukasi_pot/providers/providers.dart';
import 'package:edukasi_pot/router.dart';

void baseMain() {
  // Initialize
  AppDatabase _db = AppDatabase();
  Api _api = Api();

  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<AuthProvider>(
      builder: (context) => AuthProvider(_db, _api),
    ),
    ChangeNotifierProvider<SubjectListProvider>(
      builder: (context) => SubjectListProvider(_db, _api),
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
    );
  }
}
