import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

const double _concludeWidth = 21.0;
const double _sliderHorizontalMargin = 0.0;

class ConcludeSlider extends StatefulWidget {
  final Function onConclude;

  const ConcludeSlider({@required this.onConclude});

  @override
  _ConcludeSliderState createState() => _ConcludeSliderState();
}

class _ConcludeSliderState extends State<ConcludeSlider>
    with TickerProviderStateMixin {
  double _iconPosition = 0.0;
  AnimationController movementController;
  Animation<double> sliderAnimation;
  Color _concludeBg = Color(0xFFEDF1F4);
  Color _textColor = Color(0xFF858E99);

  @override
  void initState() {
    super.initState();
    movementController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
  }

  @override
  void dispose() {
    movementController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.0),
      height: screenAwareSize(55.0, context),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
        color: _concludeBg,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return GestureDetector(
            behavior: HitTestBehavior.translucent,
            child: Stack(
              alignment: Alignment.centerRight,
              children: <Widget>[
                ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: double.infinity),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Center(
                      child: Text(
                        'Conclude Class',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: _textColor,
                        ),
                      ),
                    ),
                  ),
                ),
                _drawConcludeSlider(width: constraints.maxWidth),
              ],
            ),
          );
        },
      ),
    );
  }

  void _confirmConclude() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFF2E333D),
          title: Text(
            "Conclude the class?",
            style: TextStyle(
              fontSize: 18.0,
              color: Color(0xFFE2E3EB),
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                "No",
                style: TextStyle(
                  color: Color(0xFFE2E3EB),
                  fontSize: 16.0,
                ),
              ),
              onPressed: () {
                _cancelConclude();
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text(
                "Yes! Conclude",
                style: TextStyle(
                  color: Color(0xFFE2E3EB),
                  fontSize: 16.0,
                ),
              ),
              onPressed: widget.onConclude,
            ),
          ],
        );
      },
    );
  }

  Widget _drawConcludeSlider({double width}) {
    if (sliderAnimation == null && width != 0.0) {
      sliderAnimation = _initConcludeAnimation(width);
    }
    return Positioned(
      left: _iconPosition,
      child: GestureDetector(
        onHorizontalDragUpdate: (details) => _onConcludeDrag(width, details),
        onHorizontalDragEnd: (details) => _onConcludeEnd(width, details),
        child: ConcludeIcon(),
      ),
    );
  }

  Animation<double> _initConcludeAnimation(double width) {
    Animation<double> animation = Tween(
      begin: _iconMinPosition(),
      end: _iconMaxPosition(width),
    ).animate(movementController);

    animation.addListener(() {
      setState(() {
        _iconPosition = animation.value;
      });
      if (animation.status == AnimationStatus.completed) {
        _onSubmited();
      }
    });
    return animation;
  }

  _onSubmited() {
    Future.delayed(Duration(milliseconds: 500), () => _confirmConclude());
  }

  _onConcludeDrag(double width, DragUpdateDetails details) {
    setState(() {
      _iconPosition += details.delta.dx;
      _iconPosition = math.max(
          _iconMinPosition(), math.min(_iconMaxPosition(width), _iconPosition));
    });
  }

  _onConcludeEnd(double width, DragEndDetails details) {
    movementController.forward(from: _iconPosition / _iconMaxPosition(width));
    _concludeBg = Color(0xFF769ced);
    _textColor = Colors.white;
  }

  _cancelConclude() {
    setState(() {
      _iconPosition = _iconMinPosition();
      _concludeBg = Color(0xFFEDF1F4);
      _textColor = Color(0xFF858E99);
    });
  }

  double _iconMinPosition() =>
      screenAwareSize(_sliderHorizontalMargin, context);

  double _iconMaxPosition(double sliderWidth) =>
      sliderWidth - screenAwareSize(105.0 / 2 + _concludeWidth, context);
}

class ConcludeIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF5B87EC),
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        child: Icon(
          Icons.apps,
          color: Colors.white,
        ),
      ),
    );
  }
}

double screenAwareSize(double size, BuildContext context) {
  double drawingHeight =
      MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
  return size * drawingHeight / MediaQuery.of(context).size.height;
}
