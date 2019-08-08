import 'package:edukasi_pot/screens/subject/subject_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';

import 'package:edukasi_pot/models/models.dart';
import 'package:edukasi_pot/providers/providers.dart';
import 'package:edukasi_pot/screens/subject/subject.dart';
import 'package:edukasi_pot/widgets/route_argument.dart';

class SubjectListScreen extends StatefulWidget {
  static const routeName = '/subject-list';

  final List<Subject> subjectList;

  const SubjectListScreen({this.subjectList});

  @override
  _SubjectListScreenState createState() => _SubjectListScreenState();
}

class _SubjectListScreenState extends State<SubjectListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(
              top: 84.0, left: 88.0, right: 96.0, bottom: 72.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 12.0),
              Center(
                child: Text('This is your schedules today',
                    style: TextStyle(color: Colors.black, fontSize: 42.0)),
              ),
              SizedBox(height: 42.0),
              Expanded(
                child: _SubjectListView(subjectList: widget.subjectList),
              ),
              Container(
                width: 320.0,
                margin: EdgeInsets.only(left: 350.0, top: 64.0, bottom: 18.0),
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.black12,
                        offset: Offset(9.0, 8.0),
                        blurRadius: 16.0,
                        spreadRadius: 4.0),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () async {
                      final authProv =
                          Provider.of<AuthProvider>(context, listen: false);
                      await authProv.logout();
                    },
                    borderRadius: BorderRadius.circular(16.0),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(
                        child: Text(
                          'Log Out',
                          style: TextStyle(
                            fontSize: 28.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SubjectListView extends StatelessWidget {
  const _SubjectListView({
    Key key,
    @required this.subjectList,
  }) : super(key: key);

  final List<Subject> subjectList;

  String _formatTime(DateTime dT) {
    final _local = dT.toLocal();
    return DateFormat('HH:mm').format(_local).toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: ListView.builder(
        padding: EdgeInsets.only(bottom: 20.0),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: subjectList.length,
        itemBuilder: (BuildContext context, int index) {
          var subj = subjectList[index];
          return Container(
            padding: EdgeInsets.all(8.0),
            child: SubjectCard(
              subject: subj,
              setting: SubjectCardSetting.card,
            ),
          );
        },
      ),
    );
  }
}
