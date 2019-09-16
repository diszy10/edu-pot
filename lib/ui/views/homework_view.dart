import 'dart:math';

import 'package:edukasi_pot/core/enums/viewstate.dart';
import 'package:edukasi_pot/core/services/api/models.dart';
import 'package:edukasi_pot/core/viewmodels/viewmodels.dart';
import 'package:edukasi_pot/ui/shared/shared.dart';
import 'package:edukasi_pot/ui/views/base_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomeworkView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<HomeworkModel>(
      onModelReady: (model) =>
          model.getHomeworksForSubject(Provider.of<Subject>(context).id),
      builder: (context, model, _) => Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Title page & navigation
            Container(
              padding: edgeSymmetric(context, 7, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  horizontalSpaceSmall(context),
                  horizontalSpaceLarge(context),
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
                        verticalSpaceSmall(context),
                        Text(
                          'Based on your teaching session',
                          style: TextStyle(
                            color: Color(0xFFA29C9D),
                            fontSize: 18.0,
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
                        onTap: () => model.navigateToAttendance(),
                        borderRadius: BorderRadius.circular(16.0),
                        child: Padding(
                          padding: edgeSymmetric(context, 3, 1.5),
                          child: Text(
                            'Continue',
                            style: TextStyle(
                              color: Color(0xFF5771AD),
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),

            // Homework list
            model.state == ViewState.Busy
                ? Loader()
                : model.homeworks != null
                    ? _HomeworkList(model: model)
                    : Center(
                        child: Text(
                          'No data found.',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}

class _HomeworkList extends StatelessWidget {
  final HomeworkModel model;

  const _HomeworkList({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: edgeHorizontal(context, 5),
        child: GridView.builder(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: model.homeworks.length,
          itemBuilder: (ctx, i) =>
              _HomeworkItem(homework: model.homeworks[i], model: model),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 16 / 9,
            crossAxisSpacing: 0,
            mainAxisSpacing: 0,
          ),
        ),
      ),
    );
  }
}

class _HomeworkItem extends StatelessWidget {
  final Homework homework;
  final HomeworkModel model;

  const _HomeworkItem({Key key, this.homework, this.model}) : super(key: key);

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
    return Container(
      margin: edgeSymmetric(context, 2, 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: colors[random.nextInt(6)],
        // color: Colors.white,
        boxShadow: <BoxShadow>[
          // BoxShadow(
          //   color: Colors.black26,
          //   offset: Offset(4.0, 8.0),
          //   blurRadius: 8.0,
          //   spreadRadius: 0.0,
          // ),
          BoxShadow(
            color: Colors.black12,
            offset: Offset(4.0, 8.0),
            blurRadius: 16.0,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => showDialog(
            barrierDismissible: true,
            context: context,
            builder: (BuildContext context) => _ActionModal(
                colors: colors,
                random: random,
                homework: homework,
                model: model),
          ),
          borderRadius: BorderRadius.circular(16.0),
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Stack(
              children: <Widget>[
                // Homework title
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      homework.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),

                // Distribute indicator
                if (homework.isDistribute == true)
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      padding: EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        color: Colors.white,
                      ),
                      child: Icon(
                        Icons.done,
                        color: Colors.grey,
                      ),
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ActionModal extends StatefulWidget {
  final HomeworkModel model;
  final Homework homework;

  final List<Color> colors;
  final Random random;

  const _ActionModal(
      {Key key, this.model, this.homework, this.colors, this.random})
      : super(key: key);

  @override
  __ActionModalState createState() => __ActionModalState();
}

class __ActionModalState extends State<_ActionModal> {
  DateTime _selectedDate;

  Future<void> _selectDate({@required String homeworkId}) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
        backgroundColor: Color(0xFF222930),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 24.0),
            width: MediaQuery.of(context).size.width * 0.350,
            height: MediaQuery.of(context).size.height * 0.650,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(width: 84.0),
                    Expanded(
                      child: Center(
                        child: Text(
                          'Deadline',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28.0,
                          ),
                        ),
                      ),
                    ),
                    // Padding(
                    //   padding: EdgeInsets.only(left: 16.0),
                    //   child: Text(
                    //     'Deadline',
                    //     style: TextStyle(
                    //       color: Colors.white,
                    //       fontSize: 28.0,
                    //       // fontWeight: FontWeight.bold,
                    //     ),
                    //   ),
                    // ),
                    FlatButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'Cancel',
                        style:
                            TextStyle(color: Color(0xFFBEC0C2), fontSize: 16.0),
                      ),
                    )
                    // Container(
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(16.0),
                    //     color: Colors.black26,
                    //   ),
                    //   child: InkWell(
                    //     onTap: () => Navigator.pop(context),
                    //     borderRadius: BorderRadius.circular(16.0),
                    //     child: Material(
                    //       color: Colors.transparent,
                    //       child: Container(
                    //         padding: EdgeInsets.all(16.0),
                    //         child: Text(
                    //           'Cancel',
                    //           style: TextStyle(color: Color(0xFFBEC0C2), fontSize: 16.0),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                SizedBox(height: 24.0),
                Expanded(
                  child: CalendarCarousel<Event>(
                    // width: MediaQuery.of(context).size.width * 0.35,
                    // height: MediaQuery.of(context).size.height * 0.510,
                    onDayPressed: (DateTime date, _) {
                      this.setState(() {
                        _selectedDate = date;
                        if (widget.homework.deadline != null &&
                            _selectedDate != widget.homework.deadline) {
                          widget.model.unDistribute(widget.homework.id);
                        }
                        Navigator.pop(context);
                      });
                    },
                    selectedDateTime: _selectedDate ?? widget.homework.deadline,
                    selectedDayButtonColor: Color(0xFF25c431),
                    selectedDayBorderColor: Color(0xFF25c431),
                    selectedDayTextStyle: TextStyle(
                      color: Colors.white,
                    ),
                    showHeader: true,
                    showHeaderButton: true,
                    iconColor: Colors.grey,
                    headerTextStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                    headerMargin: EdgeInsets.only(bottom: 32.0),
                    weekendTextStyle: TextStyle(
                      color: Colors.deepOrange,
                    ),
                    // todayButtonColor: Colors.blue,
                    // todayBorderColor: Colors.blue,
                    todayTextStyle: TextStyle(
                      color: Colors.black,
                    ),
                    daysTextStyle: TextStyle(
                      color: Colors.white,
                    ),
                    weekFormat: false,
                    daysHaveCircularBorder: false,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleDistribute() {
    if (_selectedDate == null &&
        widget.homework.deadline == null &&
        widget.homework.isDistribute == false) {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(
            'Deadline date is still empty',
            style: TextStyle(fontSize: 20.0),
          ),
          content: Text(
            'Please set deadline date before distribute.',
            style: TextStyle(fontSize: 16.0),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('OK', style: TextStyle(fontSize: 16.0)),
              textColor: Colors.deepPurple,
              onPressed: () => Navigator.pop(context),
            )
          ],
        ),
      );
    } else if (_selectedDate != null && widget.homework.isDistribute == false) {
      widget.model.setDeadline(widget.homework.id, _selectedDate);
      widget.model.setDistribute(widget.homework.id);
      Navigator.pop(context);
    } else if (widget.homework.deadline != null &&
        widget.homework.isDistribute == true) {
      widget.model.unDistribute(widget.homework.id);
      Navigator.pop(context);
    }
  }

  String _buildText() {
    if (_selectedDate == null && widget.homework.deadline == null) {
      return 'Next Session';
    } else if (_selectedDate != null && widget.homework.deadline == null) {
      return DateFormat("dd MMM yyyy").format(_selectedDate).toString();
    } else if (_selectedDate != null && widget.homework.deadline != null) {
      return DateFormat("dd MMM yyyy").format(_selectedDate).toString();
    }
    return DateFormat("dd MMM yyyy")
        .format(widget.homework.deadline)
        .toString();
  }

  @override
  Widget build(BuildContext context) {
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
            color: widget.colors[widget.random.nextInt(6)],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // Homework title
              Center(
                child: Text(
                  widget.homework.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              // Action buttons
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
                        onTap: () =>
                            _selectDate(homeworkId: widget.homework.id),
                        borderRadius: BorderRadius.circular(50.0),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 24.0),
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.flag, color: Colors.white),
                              SizedBox(width: 10.0),
                              Text(
                                _buildText(),
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
                        onTap: _handleDistribute,
                        borderRadius: BorderRadius.circular(50.0),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 24.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              widget.homework.isDistribute == true
                                  ? Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                        color: Colors.green,
                                      ),
                                      child: Icon(
                                        Icons.done,
                                        color: Colors.white,
                                      ),
                                    )
                                  : Icon(Icons.send, color: Colors.black),
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
