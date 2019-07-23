import 'package:flutter/material.dart';

import 'package:edukasi_pot/models/models.dart';
import 'package:edukasi_pot/widgets/widgets.dart';

class SubjectScreen extends StatelessWidget {
  /// Subject screen that show many modules.
  static const routeName = '/home';

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  final _moduleList = [
    Module(title: 'Decimal fractions and place value patterns'),
    Module(title: 'Decimal fractions and place value patterns'),
    Module(title: 'Decimal fractions and place value patterns'),
    Module(title: 'Decimal fractions and place value patterns'),
    Module(title: 'Decimal fractions and place value patterns'),
    Module(title: 'Decimal fractions and place value patterns'),
  ];

  @override
  Widget build(BuildContext context) {
    final Size media = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xFFF2F4F6),
      drawer: _buildDrawer(context, media),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildSidebar(context),
            SizedBox(
              width: 48.0,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFF2F4F6),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[300],
                      blurRadius: 2.0,
                      offset: Offset(-3.0, -2.0),
                    )
                  ],
                ),
              ),
            ),
            _buildBody(context, media),
            SizedBox(
              width: 48.0,
              child: Container(color: Color(0xFFF2F4F6)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context, Size media) {
    final bool target = media.height > 1000;
    return SizedBox(
      width: target ? media.width / 2 : media.width / 3,
      child: Drawer(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            /// User section and close drawer button
            Container(
              margin: EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  /// User menu
                  Row(
                    children: <Widget>[
                      /// Username text
                      Text(
                        'Deprito',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),

                      /// Expanded button
                      Container(
                        margin: EdgeInsets.only(top: 4.0, left: 4.0),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {},
                            borderRadius: BorderRadius.circular(16.0),
                            child: Container(
                              child: Icon(
                                Icons.keyboard_arrow_down,
                                size: 20.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  /// Close drawer button
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      borderRadius: BorderRadius.circular(16.0),
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.close,
                          color: Color(0xFF7B8189),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(color: Colors.grey, height: 1.0),
            SizedBox(height: 8.0),

            /// Notes section
            InkWell(
              onTap: () {},
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    /// Notes text
                    Row(
                      children: <Widget>[
                        Icon(Icons.note, color: Colors.blue),
                        SizedBox(width: 8.0),
                        Text('Notes', style: TextStyle(fontSize: 20.0)),
                      ],
                    ),

                    /// Notes indicator
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
                      decoration: BoxDecoration(
                          color: Color(0xFFFF5657),
                          borderRadius: BorderRadius.circular(16.0)),
                      child: Text(
                        '3',
                        style: TextStyle(fontSize: 18.0, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 24.0),

            /// Modules section
            Container(
              margin: EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 16.0),
              child: Text(
                'GRADE 5 MODULES',
                style: TextStyle(fontSize: 16.0, color: Color(0xFF586069)),
              ),
            ),
            _buildModuleList(_moduleList),

            Divider(color: Colors.grey, height: 1.0),
            SizedBox(height: 16.0),

            /// Slider conclude class
            ConcludeSlider(),
            SizedBox(height: 24.0),
          ],
        ),
      ),
    );
  }

  Widget _buildModuleList(List<Module> modules) {
    return Expanded(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: modules.length,
          itemBuilder: (context, index) {
            Module module = modules[index];
            int no = index;
            return InkWell(
              onTap: () {},
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.folder, color: Color(0xFF90CFE8)),
                    SizedBox(width: 12.0),
                    Expanded(
                      child: Text(
                        'Module ' + no.toString() + " " + module.title,
                        style: no == 0
                            ? TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                              )
                            : TextStyle(
                                fontSize: 18.0,
                                color: Colors.black54,
                              ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }

  Widget _buildSidebar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFFBFCFD),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[300],
            blurRadius: 2.0,
            offset: Offset(-3.0, 4.0),
          )
        ],
      ),
      child: _buildSidebarContent()
    );
  }

  Widget _buildSidebarContent() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          /// Menu icon
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => _scaffoldKey.currentState.openDrawer(),
              borderRadius: BorderRadius.circular(16.0),
              child: Container(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.menu,
                  size: 32.0,
                  color: Color(0xFF586069),
                ),
              ),
            ),
          ),

          /// Empty widget for module indicators
          Container(),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context, Size media) {
    return Expanded(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Color(0xFFF2F4F6),
          appBar: _buildAppBar(context, media),
          body: _buildContent(),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, Size media) {
    final bool target = media.height > 800;
    return PreferredSize(
      preferredSize:
          Size.fromHeight(target ? media.height / 3 : media.height / 2.3),
      child: AppBar(
        brightness: Brightness.light,
        elevation: 0.0,
        backgroundColor: Color(0xFFF2F4F6),
        flexibleSpace: _buildTopPart(context),
        automaticallyImplyLeading: false,
        bottom: _buildTabBar(context),
      ),
    );
  }

  Widget _buildTopPart(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 68.0),

        /// Topic info badge
        Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
              decoration: BoxDecoration(
                  color: Color(0xFF25C431),
                  borderRadius: BorderRadius.circular(8.0)),
              child: Icon(
                Icons.person,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 8.0),
            Text(
              'TOPIC 8',
              style: TextStyle(
                fontSize: 20.0,
                color: Color(0xFF25C431),
              ),
            )
          ],
        ),
        SizedBox(height: 16.0),

        /// Module topic text
        Text(
          'Decimal fractions and place value patterns',
          style: TextStyle(
              fontSize: 48.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF323232)),
        ),
        SizedBox(height: 32.0),
      ],
    );
  }

  Widget _buildTabBar(BuildContext context) {
    return TabBar(
      unselectedLabelColor: Color(0xFF9FA3A6),
      labelColor: Color(0xFF06A4B2),
      indicatorColor: Color(0xFF06A4B2),
      indicatorWeight: 4,
      tabs: [
        Tab(
          child: Text('Description', style: TextStyle(fontSize: 16.0)),
        ),
        Tab(
          child: Text('Exercise', style: TextStyle(fontSize: 16.0)),
        ),
      ],
    );
  }

  Widget _buildContent() {
    return TabBarView(
      children: <Widget>[DescriptionTabView(), ExerciseTabView()],
    );
  }
}

class DescriptionTabView extends StatelessWidget {
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

class ExerciseTabView extends StatelessWidget {
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
      child: _buildExerciseList(_exerciseList),
    );
  }

  Widget _buildExerciseList(List<Exercise> exercises) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: exercises.length,
      itemBuilder: (context, index) {
        Exercise exercise = exercises[index];
        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => showCustomModalBottomSheet(
                context: context,
                builder: (context) => ExerciseBottomSheet(exercise: exercise)),
            child: Container(
              padding: EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Color(0xFFCED4D7)))),
              child: Text(
                exercise.title,
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          ),
        );
      },
    );
  }
}
