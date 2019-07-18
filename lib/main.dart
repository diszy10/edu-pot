import 'package:edukasi_pot/screens/splash.dart';
import 'package:edukasi_pot/states/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:edukasi_pot/router.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<AuthNotifier>(
      builder: (_) => AuthNotifier(),
    )
  ], child: EdukasiPotApp()));
}

class EdukasiPotApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Edukasi POT',
      initialRoute: SplashScreen.routeName,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
