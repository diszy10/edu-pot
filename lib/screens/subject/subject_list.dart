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
          padding:
              const EdgeInsets.symmetric(vertical: 144.0, horizontal: 96.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: Colors.black38,
                      offset: Offset(5.0, 5.0),
                      blurRadius: 5.0)
                ], shape: BoxShape.circle),
                child: CircleAvatar(
                  backgroundColor: Colors.blueGrey,
                ),
              ),
              SizedBox(height: 42.0),
              Text(
                'Hello, NAME_HERE',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                ),
              ),
              SizedBox(height: 12.0),
              Text('This is your schedules today',
                  style: TextStyle(color: Colors.black, fontSize: 21.0)),
              SizedBox(height: 32.0),
              Container(
                  height: 224.0,
                  child: _SubjectListView(subjectList: widget.subjectList)),
              SizedBox(height: 32.0),
              Container(
                width: 300.0,
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
                            fontSize: 16.0,
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
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: subjectList.length,
        itemBuilder: (BuildContext context, int index) {
          var subj = subjectList[index];
          return Container(
            padding: EdgeInsets.all(8.0),
            child: InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(SubjectScreen.routeName,
                      arguments: RouteArgument(
                          from: SubjectListScreen.routeName, obj: subj));
                },
                child: SubjectCard(
                  subject: subj,
                  heroTag: '${subj.id}',
                  setting: SubjectCardSetting.card,
                )),
          );
        },
      ),
    );
  }
}
