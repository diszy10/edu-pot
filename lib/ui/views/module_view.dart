import 'package:edukasi_pot/core/services/api/models.dart';
import 'package:edukasi_pot/ui/shared/shared.dart';
import 'package:edukasi_pot/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ModuleView extends StatefulWidget {
  final Module module;

  const ModuleView({this.module});

  @override
  _ModuleViewState createState() => _ModuleViewState();
}

class _ModuleViewState extends State<ModuleView> with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _titleAnimation;

  @override
  void initState() {
    _controller = AnimationController(
        duration: Duration(milliseconds: 1500), vsync: this);
    _titleAnimation = Tween(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Interval(0, 0.3)));

    _controller.addListener(() {
      setState(() {});
    });
    _controller.forward();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F4F6),
      drawer: ModuleDrawer(subject: Provider.of<Subject>(context)),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            /// Sidebar
            Sidebar(),

            /// Content body
            Expanded(
              child: Container(
                margin: edgeHorizontal(context, 5),
                child: DefaultTabController(
                  length: 2,
                  child: Scaffold(
                    backgroundColor: Color(0xFFF2F4F6),
                    body: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        verticalSpaceLarge(context),

                        /// Topic info badge
                        Row(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 4.0, horizontal: 8.0),
                              decoration: BoxDecoration(
                                  color: Color(0xFF25C431),
                                  borderRadius: BorderRadius.circular(8.0)),
                              child: Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                            ),
                            horizontalSpace(context, 0.8),
                            Text(
                              'TOPIC 8',
                              style: TextStyle(
                                color: Color(0xFF25C431),
                                fontSize: 24.0,
                              ),
                            )
                          ],
                        ),
                        verticalSpaceSmall(context),

                        /// Module topic text
                        Transform.translate(
                          offset: Offset(0.0, 30 * (1 - _titleAnimation.value)),
                          child: Opacity(
                            opacity: _titleAnimation.value,
                            child: Text(
                              widget.module.title,
                              style: TextStyle(
                                color: Color(0xFF323232),
                                fontSize: 74.0,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ),
                        ),
                        verticalSpaceMedium(context),

                        /// Tabbar
                        Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: Color(0xFFCAD0D3)),
                            ),
                          ),
                          child: TabBar(
                            unselectedLabelColor: Color(0xFF9FA3A6),
                            labelColor: Color(0xFF06A4B2),
                            indicatorColor: Color(0xFF06A4B2),
                            indicatorWeight: 4.0,
                            tabs: [
                              Tab(
                                child: Text(
                                  'Description',
                                  style: TextStyle(fontSize: 20.0),
                                ),
                              ),
                              Tab(
                                child: Text(
                                  'Exercise',
                                  style: TextStyle(fontSize: 20.0),
                                ),
                              ),
                            ],
                          ),
                        ),

                        /// Tabview / tab content
                        Expanded(child: _ModuleTabView()),
                      ],
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

class _ModuleTabView extends StatelessWidget {
  const _ModuleTabView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: <Widget>[_DescriptionTabView(), _ExerciseTabView()],
    );
  }
}

class _DescriptionTabView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 32.0, horizontal: 4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'The lesson is aligned to the Common Core State Standards for Mathematics - 5MD.4 Geometric Measurement - Measure volumes by counting "unit cubes", using cubic cm, cubic in, cubic ft.',
              style: TextStyle(fontSize: 18.0, height: 1.2),
            ),
            SizedBox(height: 32.0),
            Text(
              'Suggested lesson structure',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '- Fluency Practice',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      '- Application Problem',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      '- Concept Development',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      '- Student Debrief',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      '  Total Time',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(width: 50.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '(12 minutes)',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      '(8 minutes)',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      '(30 minutes)',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      '(10 minutes)',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      '(60 minutes)',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 32.0),
            Text(
              'Fluency Practice (12 minutes)',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Sprint: Multiply by 10',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      'Rename the Units---Choral',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      'Decimal Place Value 4',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ],
                ),
                SizedBox(width: 50.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '(8 minutes)',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      '(2 minutes)',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      '(2 minutes)',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ExerciseTabView extends StatelessWidget {
  final _exerciseList = [
    Exercise(
      title: 'Decimals in expanded form',
      content:
          "Expanded form is a way to write numvers by adding the value of its digits. We can use a place value chart to think of the value of a number's digit. Exercise questions attached below",
    ),
    Exercise(
      title: 'Decimals in written form',
      content:
          "Expanded form is a way to write numvers by adding the value of its digits. We can use a place value chart to think of the value of a number's digit. Exercise questions attached below",
    ),
    Exercise(
      title: 'Compare decimalas through thousandths',
      content:
          "Expanded form is a way to write numvers by adding the value of its digits. We can use a place value chart to think of the value of a number's digit. Exercise questions attached below",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // Exercise List
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: _exerciseList.length,
        itemBuilder: (context, index) {
          Exercise exercise = _exerciseList[index];
          return Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => showCustomModalBottomSheet(
                  context: context,
                  builder: (context) =>
                      ExerciseBottomSheet(exercise: exercise)),
              child: Container(
                padding: EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                    border:
                        Border(bottom: BorderSide(color: Color(0xFFCED4D7)))),
                child: Text(
                  exercise.title,
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
