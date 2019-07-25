import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

import 'package:edukasi_pot/config/base.dart';
import 'package:edukasi_pot/states/auth.dart';
import 'package:edukasi_pot/router.dart';

void baseMain(BaseConfig config) {
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(MultiProvider(providers: [
    Provider<BaseConfig>.value(
      value: config,
      updateShouldNotify: (prev, curr) => false,
    ),
    ChangeNotifierProvider<AuthNotifier>(
      builder: (_) => AuthNotifier(),
    )
  ], child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Provider.of<BaseConfig>(context).appName,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
