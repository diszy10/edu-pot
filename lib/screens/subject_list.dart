import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';

import 'package:edukasi_pot/models/models.dart';
import 'package:edukasi_pot/providers/providers.dart';
import 'package:edukasi_pot/screens/screens.dart';
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
    );
  }
}

class _SubjectListView extends StatelessWidget {
  const _SubjectListView({
    Key key,
    @required List<Subject> subjectList,
  })  : subjectList = subjectList,
        super(key: key);

  final List<Subject> subjectList;

  String _formatTime(DateTime dT) {
    final _local = dT.toLocal();
    return DateFormat('HH:mm').format(_local).toString();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: subjectList.length,
      itemBuilder: (BuildContext context, int index) {
        var subj = subjectList[index];
        var nameTag = '${subj.id}:${subj.name}';
        var klassTag = '${subj.id}:${subj.klass}';

        return Container(
          padding: EdgeInsets.all(8.0),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(SubjectScreen.routeName,
                    arguments: RouteArgument(
                        from: SubjectListScreen.routeName, obj: subj));
              },
              child: Container(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Hero(
                      tag: nameTag,
                      child: Material(
                        color: Colors.transparent,
                        child: Text(
                          subj.name,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Hero(
                      tag: klassTag,
                      child: Material(
                        color: Colors.transparent,
                        child: Text(
                          subj.klass,
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
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
