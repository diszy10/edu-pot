import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';

import 'package:edukasi_pot/providers/providers.dart';
import 'package:edukasi_pot/screens/screens.dart';

class HomeworkScreen extends StatelessWidget {
  static const routeName = '/homeworks';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: Homeworks(),
      child: Scaffold(
        backgroundColor: Color(0xFFF9F6F5),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Top navigation, title page
            Container(
              margin: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.05,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(width: 125.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Homeworks',
                          style: TextStyle(
                            fontSize: 32.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          'Based on your teaching session',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Color(0xFFA29C9D),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFDBE7F9),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => Navigator.pushNamed(
                            context, AttendanceScreen.routeName),
                        borderRadius: BorderRadius.circular(16.0),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 32.0, vertical: 12.0),
                          child: Text(
                            'Continue',
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Color(0xFF5771AD),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            _HomeworkList()
          ],
        ),
      ),
    );
  }
}

class _HomeworkList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loadedHomeworks = Provider.of<Homeworks>(context);
    final homeworks = loadedHomeworks.item;
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 50.0),
        child: GridView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: homeworks.length,
          itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
            value: homeworks[i],
            child: _HomeworkCard(),
          ),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 16 / 9,
            crossAxisSpacing: 25,
            mainAxisSpacing: 10,
          ),
        ),
      ),
    );
  }
}

class _HomeworkCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final homework = Provider.of<Homework>(context);

    final List<Color> colors = [
      Color(0xFF007789),
      Color(0xFF3D85D3),
      Color(0xFF34BA9C),
      Color(0xFFB57E55),
      Color(0xFFF62B84),
      Color(0xFFA0B658)
    ];

    final Random random = Random();

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: colors[random.nextInt(6)],
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black26,
            offset: Offset(4.0, 8.0),
            blurRadius: 8.0,
            spreadRadius: 0.0,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => showDialog(
            barrierDismissible: true,
            context: context,
            builder: (BuildContext context) =>
                _HomeworkModal(title: homework.title),
          ),
          borderRadius: BorderRadius.circular(16.0),
          child: Container(
            padding: EdgeInsets.all(14.0),
            child: Stack(
              children: <Widget>[
                //
                // Homework title
                //
                Center(
                  child: Text(
                    homework.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                //
                // Distribute indicator
                //
                // Align(
                //   alignment: Alignment.bottomRight,
                //   child: Container(
                //     padding: EdgeInsets.all(4.0),
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(50.0),
                //       color: Colors.white,
                //     ),
                //     child: Icon(
                //       Icons.done,
                //       color: Colors.grey,
                //     ),
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HomeworkModal extends StatefulWidget {
  final String title;

  const _HomeworkModal({Key key, this.title}) : super(key: key);

  @override
  _HomeworkModalState createState() => _HomeworkModalState();
}

class _HomeworkModalState extends State<_HomeworkModal> {
  // DateTime selectedDate = DateTime.now();

  String _selectedDate = 'Next Session';

  bool isDistribute;

  Future _selectDate() async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime(2020),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.dark(),
          child: child,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _selectedDate = DateFormat("dd MMM yyyy").format(picked).toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Color> colors = [
      Color(0xFF007789),
      Color(0xFF3D85D3),
      Color(0xFF34BA9C),
      Color(0xFFB57E55),
      Color(0xFFF62B84),
      Color(0xFFA0B658)
    ];

    final Random random = Random();

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.height * 0.3,
          padding: EdgeInsets.all(50.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: colors[random.nextInt(6)],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Center(
                child: Text(
                  widget.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                    fontSize: 18.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      color: Colors.black26,
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => _selectDate(),
                        borderRadius: BorderRadius.circular(50.0),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 24.0),
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.flag, color: Colors.white),
                              SizedBox(width: 10.0),
                              Text(
                                _selectedDate,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      color: Colors.white,
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => Navigator.pop(context),
                        borderRadius: BorderRadius.circular(50.0),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 24.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Icon(Icons.send, color: Colors.black),
                              SizedBox(width: 10.0),
                              Text(
                                'Distribute',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
