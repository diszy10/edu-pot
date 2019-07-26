import 'package:flutter/material.dart';

import 'package:edukasi_pot/models/models.dart';
import 'package:edukasi_pot/widgets/widgets.dart';

class ModuleTabView extends StatelessWidget {
  const ModuleTabView({
    Key key,
  }) : super(key: key);

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
