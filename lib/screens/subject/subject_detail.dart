import 'package:flutter/material.dart';

import 'package:edukasi_pot/models/models.dart';
import 'package:edukasi_pot/screens/subject/subject_card.dart';

class SubjectScreen extends StatelessWidget {
  static const routeName = '/subject';

  final Subject subject;

  const SubjectScreen({this.subject});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF00716B),
      body: SafeArea(
        child: Center(
          child: SubjectCard(
            subject: subject,
            heroTag: '${subject.id}',
            setting: SubjectCardSetting.screen,
          ),
        ),
      ),
    );
  }
}

class ScheduleModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF737373),
      height: MediaQuery.of(context).size.height * 8 / 9.5,
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            )),
        child: Text('List'),
      ),
    );
  }
}
