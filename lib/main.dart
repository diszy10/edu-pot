import 'package:flutter/material.dart';

import './screens/login.dart';
import './router.dart';

void main() {
  EdukasiPotRouter.setupRouter();
  runApp(EdukasiPotApp());
}

class EdukasiPotApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Edukasi POT',
      initialRoute: 'login',
      onGenerateRoute: EdukasiPotRouter.router.generator,
    );
  }
}
