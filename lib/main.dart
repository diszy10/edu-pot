import 'package:edukasi_pot/config/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

import 'package:edukasi_pot/states/auth.dart';
import 'package:edukasi_pot/router.dart';

void baseMain() {
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<AuthNotifier>(
      builder: (_) => AuthNotifier(),
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
