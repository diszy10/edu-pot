import 'dart:math' as math;

import 'package:flutter/material.dart';

const double _pacmanWidth = 21.0;
const double _sliderHorizontalMargin = 0.0;

class ConcludeSlider extends StatefulWidget {
  @override
  _ConcludeSliderState createState() => _ConcludeSliderState();
}

class _ConcludeSliderState extends State<ConcludeSlider>
    with TickerProviderStateMixin {
  double _pacmanPosition = 0.0;
  AnimationController pacmanMovementController;
  Animation<double> pacmanAnimation;

  @override
  void initState() {
    super.initState();
    pacmanMovementController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
  }

  @override
  void dispose() {
    pacmanMovementController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Decoration decoration = BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(30.0)),
      color: Color(0xFFEDF1F4),
    );

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.0),
      height: screenAwareSize(55.0, context),
      decoration: decoration,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => _animatePacmanToEnd(width: constraints.maxWidth),
            child: Stack(
              alignment: Alignment.centerRight,
              children: <Widget>[
                // AnimatedDots(),
                // _drawDotCurtain(decoration, width: constraints.maxWidth),
                ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: double.infinity),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Center(
                      child: Text(
                        'Conclude Class',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Color(0xFF858E99),
                        ),
                      ),
                    ),
                  ),
                ),
                _drawPacman(width: constraints.maxWidth),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _drawPacman({double width}) {
    if (pacmanAnimation == null && width != 0.0) {
      pacmanAnimation = _initPacmanAnimation(width);
    }
    return Positioned(
      left: _pacmanPosition,
      child: GestureDetector(
        onHorizontalDragUpdate: (details) => _onPacmanDrag(width, details),
        onHorizontalDragEnd: (details) => _onPacmanEnd(width, details),
        child: PacmanIcon(),
      ),
    );
  }

  Animation<double> _initPacmanAnimation(double width) {
    Animation<double> animation = Tween(
      begin: _pacmanMinPosition(),
      end: _pacmanMaxPosition(width),
    ).animate(pacmanMovementController);

    animation.addListener(() {
      setState(() {
        _pacmanPosition = animation.value;
      });
      if (animation.status == AnimationStatus.completed) {
        _onPacmanSubmited();
      }
    });
    return animation;
  }

  _onPacmanSubmited() {
    //temporary:
    Future.delayed(Duration(milliseconds: 500), () => Navigator.pop(context));
  }

  _onPacmanDrag(double width, DragUpdateDetails details) {
    setState(() {
      _pacmanPosition += details.delta.dx;
      _pacmanPosition = math.max(_pacmanMinPosition(),
          math.min(_pacmanMaxPosition(width), _pacmanPosition));
    });
  }

  _onPacmanEnd(double width, DragEndDetails details) {
    bool isOverHalf =
        _pacmanPosition + screenAwareSize(_pacmanWidth / 2, context) >
            0.5 * width;
    if (isOverHalf) {
      _animatePacmanToEnd(width: width);
    } else {
      _resetPacman();
    }
  }

  _animatePacmanToEnd({double width}) {
    pacmanMovementController.forward(
        from: _pacmanPosition / _pacmanMaxPosition(width));
  }

  _resetPacman() {
    setState(() => _pacmanPosition = _pacmanMinPosition());
  }

  double _pacmanMinPosition() =>
      screenAwareSize(_sliderHorizontalMargin, context);

  double _pacmanMaxPosition(double sliderWidth) =>
      sliderWidth - screenAwareSize(105.0 / 2 + _pacmanWidth, context);
}

class PacmanIcon extends StatelessWidget {
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
