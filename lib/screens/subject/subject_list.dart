import 'package:after_layout/after_layout.dart';
import 'package:edukasi_pot/providers/providers.dart';
import 'package:flutter/material.dart';

import 'package:edukasi_pot/models/models.dart';
import 'package:edukasi_pot/screens/subject/subject_card.dart';
import 'package:provider/provider.dart';

class SubjectListScreen extends StatefulWidget {
  static const routeName = '/subject-list';

  final List<Subject> subjectList;
  final Subject subjectSelected;

  const SubjectListScreen({this.subjectList, this.subjectSelected});

  @override
  _SubjectListScreenState createState() => _SubjectListScreenState();
}

class _SubjectListScreenState extends State<SubjectListScreen> {
  Subject subjectInSession;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      var _subject =
          await Provider.of<SubjectProvider>(context).subjectInSession;

      setState(() {
        subjectInSession = _subject;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9F6F5),
      body: SafeArea(
        child: Container(
          // padding: const EdgeInsets.only(
          //     top: 144.0, left: 88.0, right: 96.0, bottom: 216.0),
          padding: const EdgeInsets.only(
              top: 144.0, left: 88.0, right: 96.0, bottom: 180.0),
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
              SizedBox(height: 50.0),
              _SubjectListView(
                subjectList: widget.subjectList,
                subjectSelected: widget.subjectSelected,
                subjectInSession: subjectInSession,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SubjectListView extends StatefulWidget {
  const _SubjectListView({
    Key key,
    @required this.subjectList,
    @required this.subjectSelected,
    @required this.subjectInSession,
  }) : super(key: key);

  final List<Subject> subjectList;
  final Subject subjectSelected;
  final Subject subjectInSession;

  @override
  _SubjectListViewState createState() => _SubjectListViewState();
}

class _SubjectListViewState extends State<_SubjectListView>
    with AfterLayoutMixin<_SubjectListView> {
  ScrollController _controller;

  @override
  void initState() {
    super.initState();

    _controller = ScrollController(initialScrollOffset: 0.0);
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _setScrollPosition();
  }

  _setScrollPosition() {
    var index = widget.subjectList.indexOf(widget.subjectSelected);
    if (index != -1) {
      var scrollOffset = index * 420.0;
      var maxOffset = _controller.position.maxScrollExtent;
      if (scrollOffset > maxOffset) {
        scrollOffset = maxOffset;
      }

      _controller.jumpTo(scrollOffset);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Scrollbar(
        child: ListView.builder(
          padding: EdgeInsets.only(bottom: 20.0),
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: widget.subjectList.length,
          controller: _controller,
          itemBuilder: (BuildContext context, int index) {
            var subj = widget.subjectList[index];
            return Container(
              padding: EdgeInsets.all(8.0),
              child: SubjectCard(
                subject: subj,
                setting: SubjectCardSetting.card,
                inSession: subj == widget.subjectInSession,
              ),
            );
          },
        ),
      ),
    );
  }
}
