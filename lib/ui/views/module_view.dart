import 'package:edukasi_pot/core/services/api/models.dart';
import 'package:edukasi_pot/ui/shared/shared.dart';
import 'package:edukasi_pot/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;

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
      drawer: ModuleDrawer(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Sidebar(),

            // Module content
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
                        verticalSpaceMedium(context),

                        // Topic info badge
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
                              'TOPIC 1',
                              style: TextStyle(
                                color: Color(0xFF25C431),
                                fontSize: 24.0,
                              ),
                            )
                          ],
                        ),
                        verticalSpaceSmall(context),

                        // Module topic text
                        Transform.translate(
                          offset: Offset(0.0, 30 * (1 - _titleAnimation.value)),
                          child: Opacity(
                            opacity: _titleAnimation.value,
                            child: Text(
                              widget.module.title,
                              style: TextStyle(
                                color: Color(0xFF323232),
                                fontSize: 54.0,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ),
                        ),
                        verticalSpaceSmall(context),

                        // Tabbar
                        Container(
                          height: heightBox(context, 8),
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

                        // Tabview module content
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

class _DescriptionTabView extends StatefulWidget {
  @override
  __DescriptionTabViewState createState() => __DescriptionTabViewState();
}

class __DescriptionTabViewState extends State<_DescriptionTabView>
    with TickerProviderStateMixin {
  static String html = '''
<p style="font-size: 40px;">The lesson is alligned to the Common Core State Standards for Mathematics - 5MD.4 Geometric Measurement - Measure
    volumes by counting "unit cubes", using cubic cm, cuibc in, cubic ft.</p>

<h1>Suggested Lesson Structure</h1>
<table>
    <tr>
        <td> - Fluency Practice</td>
        <td>(12 minutes)</td>
    </tr>
    <tr>
        <td> - Application Problem</td>
        <td>(8 minutes)</td>
    </tr>
    <tr>
        <td> - Concept Development</td>
        <td>(30 minutes)</td>
    </tr>
    <tr>
        <td> - Student Debrief</td>
        <td>(10 minutes)</td>
    </tr>
    <tr>
        <td>
            <strong>Total Time</strong>
        </td>
        <td>
            <strong>(60 minutes)</strong>
        </td>
    </tr>
</table>

<h1>Fluency Practice (12 minutes)</h1>
<table>
    <tr>
        <td>Sprint: Multiply by 10</td>
        <td>(8 minutes)</td>
    </tr>
    <tr>
        <td>Rename the Units - Choral</td>
        <td>(2 minutes)</td>
    </tr>
    <tr>
        <td>Decimal Place Value 5</td>
        <td>(2 minutes)</td>
    </tr>
</table>
  ''';

  AnimationController _controller;
  Animation<double> _descriptionAnimation;

  @override
  void initState() {
    _controller = AnimationController(
        duration: Duration(milliseconds: 1500), vsync: this);
    _descriptionAnimation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _controller, curve: Interval(0.3, 0.5)));

    _controller.addListener(() {
      setState(() {});
    });
    _controller.forward();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 4.0),
        child: Transform.translate(
          offset: Offset(0.0, 30 * (1 - _descriptionAnimation.value)),
          child: Opacity(
            opacity: _descriptionAnimation.value,
            child: Html(
              data: html,
              customTextStyle: (dom.Node node, TextStyle baseStyle) {
                if (node is dom.Element) {
                  switch (node.localName) {
                    case "p":
                      return baseStyle
                          .merge(TextStyle(fontSize: 20.0, height: 1.5));
                    case "td":
                      return baseStyle
                          .merge(TextStyle(fontSize: 20.0, height: 1.5));
                  }
                }
                return baseStyle;
              },
            ),
          ),
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
                builder: (context) => ExerciseBottomSheet(exercise: exercise),
              ),
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
