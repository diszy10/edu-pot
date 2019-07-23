import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

import 'package:edukasi_pot/states/auth.dart';
import 'package:edukasi_pot/router.dart';

void main() {
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<AdminAuthNotifier>(
      builder: (_) => AdminAuthNotifier(),
    )
  ], child: _mainApp()));
}

Widget _mainApp() {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Edukasi POT',
    onGenerateRoute: AppRouter.generateRoute,
  );
}
