import 'package:edukasi_pot/core/enums/viewstate.dart';
import 'package:edukasi_pot/core/services/api/models.dart';
import 'package:edukasi_pot/core/viewmodels/viewmodels.dart';
import 'package:edukasi_pot/ui/shared/shared.dart';
import 'package:edukasi_pot/ui/views/base_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomeworkView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<HomeworkModel>(
      onModelReady: (model) =>
          model.getHomeworksForSubject(Provider.of<Subject>(context).id),
      builder: (context, model, _) => Scaffold(
        backgroundColor: Color(0xFFF6F8F9),
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
            model.state == ViewState.Busy ? Loader() : _HomeworkList()
          ],
        ),
      ),
    );
  }
}

class _HomeworkList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<HomeworkModel>(context);
    return Expanded(
      child: Padding(
        padding: edgeHorizontal(context, 5),
        child: GridView.builder(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: model.homeworks.length,
          itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
              value: model.homeworks[i], child: _HomeworkItem()),
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
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<HomeworkModel>(context);
    final homework = Provider.of<Homework>(context);
    return Container(
      margin: edgeSymmetric(context, 2, 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: homework.color ?? Colors.white,
        boxShadow: <BoxShadow>[
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
            builder: (BuildContext context) => MultiProvider(providers: [
              ChangeNotifierProvider.value(
                value: model,
              ),
              ChangeNotifierProvider.value(
                value: homework,
              )
            ], child: _ActionModal()),
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
                        color: homework.color != null
                            ? Colors.white
                            : Colors.black,
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
  @override
  __ActionModalState createState() => __ActionModalState();
}

class __ActionModalState extends State<_ActionModal> {
  DateTime _selectedDate;

  Future<void> _selectDate(Homework homework, HomeworkModel model) async {
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
                        if (homework.deadline != null &&
                            _selectedDate != homework.deadline) {
                          model.unDistribute(homework.id);
                        }
                        Navigator.pop(context);
                      });
                    },
                    selectedDateTime: _selectedDate ?? homework.deadline,
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

  void _selectColor(Homework homework, HomeworkModel model) {
    // Navigator.pop(context);
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Material(
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
            ),
            width: MediaQuery.of(context).size.width * 0.3,
            height: MediaQuery.of(context).size.height * 0.325,
            padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: MaterialColorPicker(
              onColorChange: (Color color) {
                model.setColor(homework.id, color);
                Navigator.pop(context);
              },
              onlyShadeSelection: true,
              circleSize: 180.0,
              spacing: 24.0,
              selectedColor: homework.color,
              // colors: [
              //   Colors.red,
              //   Colors.deepOrange,
              //   Colors.yellowAccent,
              //   Colors.greenAccent,
              //   Colors.blueAccent,
              //   Colors.deepPurple,
              // ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleDistribute(Homework homework, HomeworkModel model) {
    if (_selectedDate == null &&
        homework.deadline == null &&
        homework.isDistribute == false) {
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
    } else if (_selectedDate != null && homework.isDistribute == false) {
      model.setDeadline(homework.id, _selectedDate);
      model.setDistribute(homework.id);
      Navigator.pop(context);
    } else if (homework.deadline != null && homework.isDistribute == true) {
      model.unDistribute(homework.id);
      Navigator.pop(context);
    }
  }

  String _buildText(Homework homework) {
    if (_selectedDate == null && homework.deadline == null) {
      return 'Next Session';
    } else if (_selectedDate != null && homework.deadline == null) {
      return DateFormat("dd MMM yyyy").format(_selectedDate).toString();
    } else if (_selectedDate != null && homework.deadline != null) {
      return DateFormat("dd MMM yyyy").format(_selectedDate).toString();
    }
    return DateFormat("dd MMM yyyy").format(homework.deadline).toString();
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<HomeworkModel>(context);
    final homework = Provider.of<Homework>(context);
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.height * 0.325,
          // padding: EdgeInsets.all(50.0),
          // padding: edgeSymmetric(context, 3, 3),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              // color: widget.colors[widget.random.nextInt(6)],
              color: homework.color ?? Colors.white),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // Close button
              Padding(
                padding: EdgeInsets.only(top: 16.0, right: 16.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      // border: Border.all(color: Colors.black45)
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => Navigator.pop(context),
                        borderRadius: BorderRadius.circular(50.0),
                        child: Container(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.close,
                                color: homework.color != null
                                    ? Colors.white
                                    : Colors.black45)),
                      ),
                    ),
                  ),
                ),
              ),

              // Homework title
              Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.025),
                child: Text(
                  homework.title,
                  style: TextStyle(
                    color: homework.color != null ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              // Action buttons
              Container(
                padding: EdgeInsets.only(right: 32.0, bottom: 32.0, left: 32.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        // Deadline date button
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50.0),
                            border: homework.color == null
                                ? Border.all(color: orange)
                                : null,
                            color:
                                homework.color != null ? Colors.black26 : null,
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () => _selectDate(homework, model),
                              borderRadius: BorderRadius.circular(50.0),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 16.0, horizontal: 24.0),
                                child: Row(
                                  children: <Widget>[
                                    Icon(Icons.flag,
                                        color: homework.color == null
                                            ? orange
                                            : Colors.white),
                                    SizedBox(width: 10.0),
                                    Text(
                                      _buildText(homework),
                                      style: TextStyle(
                                        color: homework.color == null
                                            ? orange
                                            : Colors.white,
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
                        horizontalSpace(context, 2),
                        // Change color button
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50.0),
                            border: homework.color == null
                                ? Border.all(color: Colors.black26)
                                : null,
                            color:
                                homework.color != null ? Colors.black26 : null,
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () => _selectColor(homework, model),
                              borderRadius: BorderRadius.circular(50.0),
                              child: Container(
                                padding: EdgeInsets.all(16.0),
                                child: Icon(
                                  Icons.color_lens,
                                  color: homework.color == null
                                      ? Colors.black45
                                      : Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Distribute button
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        // border: Border.all(color: Color(0xFFFF5B30)),
                        color: homework.color != null ? Colors.white : deepBlue,
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => _handleDistribute(homework, model),
                          borderRadius: BorderRadius.circular(50.0),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 24.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                homework.isDistribute == true
                                    ? Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                          color: Colors.green,
                                        ),
                                        child: Icon(Icons.done,
                                            color: Colors.white),
                                      )
                                    : Icon(Icons.send,
                                        color: homework.color != null
                                            ? Colors.black
                                            : Colors.white),
                                SizedBox(width: 10.0),
                                Text(
                                  'Distribute',
                                  style: TextStyle(
                                    color: homework.color != null
                                        ? Colors.black
                                        : Colors.white,
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
