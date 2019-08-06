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
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome back,',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
              ),
            ),
            SizedBox(height: 32.0),
            FutureBuilder(
              future: _listFuture,
              builder: (context, snapshot) {
                _subjectList = snapshot.data;
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(child: CircularProgressIndicator());
                  case ConnectionState.done:
                    if (snapshot.hasError) {
                      return error;
                    }
                    return _SubjectListView(subjectList: snapshot.data);
                  default:
                    return error;
                }
              },
            ),
            SizedBox(height: 32.0),
            InkWell(
              onTap: () async {
                final authProv =
                    Provider.of<AuthProvider>(context, listen: false);
                await authProv.logout();
              },
              child: Text(
                'Log out',
                style: TextStyle(
                  color: Colors.black,
                  // fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _subjectList.length,
      itemBuilder: (BuildContext context, int index) {
        Subject subj = _subjectList[index];

        String startTime = _formatTime(subj.startTime);
        String endTime = _formatTime(subj.endTime);
        String subStr = '${subj.name} ${subj.klass}  ${startTime} ~ ${endTime}';
        return Container(
          padding: EdgeInsets.all(8.0),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                Navigator.of(context)
                    .pushNamed(SubjectScreen.routeName, arguments: subj);
              },
              child: Container(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      subj.name,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      subj.klass,
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
