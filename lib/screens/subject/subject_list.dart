import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:edukasi_pot/models/models.dart';
import 'package:edukasi_pot/providers/providers.dart';
import 'package:edukasi_pot/screens/subject/subject_card.dart';

class SubjectListScreen extends StatefulWidget {
  static const routeName = '/subject-list';

  final List<Subject> subjectList;

  const SubjectListScreen({this.subjectList});

  @override
  _SubjectListScreenState createState() => _SubjectListScreenState();
}

class _SubjectListScreenState extends State<SubjectListScreen> {
  Subject subject;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _subjectInSession(context);
    });
  }

  Future<void> _subjectInSession(BuildContext context) async {
    var _subject = await Provider.of<SubjectProvider>(context).subjectInSession;

    setState(() {
      subject = _subject;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9F6F5),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(
              top: 144.0, left: 88.0, right: 96.0, bottom: 216.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 12.0),
              Center(
                child: Text('Your Schedules Today',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 40.0,
                        fontWeight: FontWeight.w400)),
              ),
              SizedBox(height: 46.0),
              // TODO (Pradisz): Save scroll position
              Expanded(
                child: _SubjectListView(
                  subjectList: widget.subjectList,
                  subject: subject,
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
  const _SubjectListView(
      {Key key, @required this.subjectList, @required this.subject})
      : super(key: key);

  final List<Subject> subjectList;
  final Subject subject;

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
              selected: subj == subject,
            ),
          );
        },
      ),
    );
  }
}
