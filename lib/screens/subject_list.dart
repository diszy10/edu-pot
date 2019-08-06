import 'package:edukasi_pot/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';

import 'package:edukasi_pot/models/models.dart';
import 'package:edukasi_pot/providers/providers.dart';

class SubjectListScreen extends StatefulWidget {
  static const routeName = '/subject-list';
  @override
  _SubjectListScreenState createState() => _SubjectListScreenState();
}

class _SubjectListScreenState extends State<SubjectListScreen> {
  Future<List<Subject>> _listFuture;
  List<Subject> _subjectList;

  @override
  void initState() {
    super.initState();
    _listFuture = Future.delayed(Duration.zero, () {
      return Provider.of<SubjectListProvider>(context).subjectList;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget error = Center(
      child: Text(
        "Something's wrong",
        style: TextStyle(fontSize: 32),
      ),
    );

    return Scaffold(
        body: FutureBuilder(
            future: _listFuture,
            builder: (context, listSnapshot) {
              _subjectList = listSnapshot.data;
              switch (listSnapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());
                case ConnectionState.done:
                  if (listSnapshot.hasError) {
                    return error;
                  }
                  return _SubjectListView(subjectList: _subjectList);
                default:
                  return error;
              }
            }));
  }
}

class _SubjectListView extends StatelessWidget {
  const _SubjectListView({
    Key key,
    @required List<Subject> subjectList,
  })  : _subjectList = subjectList,
        super(key: key);

  final List<Subject> _subjectList;

  String _formatTime(DateTime dT) {
    final _local = dT.toLocal();
    return DateFormat('HH:mm').format(_local).toString();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: _subjectList.length,
          itemBuilder: (BuildContext context, int index) {
            Subject subj = _subjectList[index];

            String startTime = _formatTime(subj.startTime);
            String endTime = _formatTime(subj.endTime);
            String subStr =
                '${subj.name} ${subj.klass}  ${startTime} ~ ${endTime}';
            return Center(
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(SubjectScreen.routeName, arguments: subj);
                  },
              child: Text(
                subStr,
                style: TextStyle(fontSize: 40),
              ),
            ));
          },
        ),
        SizedBox(
          height: 20,
        ),
        InkWell(
          onTap: () async {
            final authProv = Provider.of<AuthProvider>(context, listen: false);
            await authProv.logout();
          },
          child: Text('Log out',
              style: TextStyle(
                  color: Color(0xFF53A49F),
                  fontWeight: FontWeight.bold,
                  fontSize: 32.0)),
        ),
      ],
    );
  }
}
