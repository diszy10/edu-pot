import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:edukasi_pot/providers/providers.dart';
import 'package:edukasi_pot/screens/screens.dart';
import 'package:edukasi_pot/widgets/widgets.dart';

Future<void> login(BuildContext context, String email, String password) async {
  try {
    final authProv = Provider.of<AuthProvider>(context, listen: false);
    await authProv.login(email, password);
    final subProv = Provider.of<SubjectProvider>(context, listen: false);
    var subject = await subProv.subjectInSession;

    if (subject == null) {
      var _list = await subProv.subjectList;
      Navigator.of(context).pushReplacementNamed(SubjectListScreen.routeName,
          arguments: SubjectListArgument(data: _list));
    } else {
      Navigator.of(context).pushReplacementNamed(SubjectScreen.routeName,
          arguments: RouteArgument(data: subject));
    }
  } catch (e) {
    rethrow;
  }
}

Future<void> logout(BuildContext context) async {
  try {
    final authProv = Provider.of<AuthProvider>(context, listen: false);
    await authProv.logout();

    await Provider.of<SubjectProvider>(context).onLogout();
    Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
  } catch (e) {
    rethrow;
  }
}
