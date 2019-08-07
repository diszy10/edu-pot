import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:edukasi_pot/models/models.dart';
import 'package:edukasi_pot/providers/providers.dart';
import 'package:edukasi_pot/screens/screens.dart';
import 'package:edukasi_pot/widgets/builder.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = '/';

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Future<bool> isLoading;
  List<Subject> subjectList = [];
  Subject subject;

  bool isSelected = false;

  @override
  void initState() {
    super.initState();
    // Future delayed so context is accessible.
    isLoading = Future.delayed(Duration(milliseconds: 450), () async {
      var _isAuth = await Provider.of<AuthProvider>(context).isUserAuth;

      if (_isAuth) {
        var subProv = Provider.of<SubjectProvider>(context);
        subject = await subProv.subjectInSession;
        if (subject == null) {
          subjectList = await subProv.subjectList;
        } else {
          isSelected = true;
        }
      }

      return _isAuth;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedFutureBuilder(
        duration: Duration(milliseconds: 450),
        future: isLoading,
        builder: (context, authSnapshot) {
          switch (authSnapshot.connectionState) {
            case ConnectionState.waiting:
              // Show splash screen when waiting for result.
              return SplashScreen();
            case ConnectionState.done:
              // If result is true, then user is authenticated
              if (authSnapshot.data) {
                if (isSelected) {
                  return SubjectScreen(subject: subject);
                } else {
                  return SubjectListScreen(
                    subjectList: subjectList,
                  );
                }
              }
              break;
            default:
              break;
          }
          return LoginScreen();
        });
  }
}
