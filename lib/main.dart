import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './screens/login.dart';

void main() {
  runApp(EdukasiPoTApp());
}

class EdukasiPoTApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Edukasi POT',
      home: LoginPage(),
    );
  }
}
