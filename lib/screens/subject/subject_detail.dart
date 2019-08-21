
import 'package:edukasi_pot/models/models.dart';
import 'package:edukasi_pot/screens/subject/subject_card.dart';
import 'package:flutter/material.dart';

class SubjectScreen extends StatelessWidget {
  static const routeName = '/subject';

  final Subject subject;

  const SubjectScreen({this.subject});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/graphics/bg-subject.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Center(
              child: SubjectCard(
                subject: subject,
                setting: SubjectCardSetting.screen,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
