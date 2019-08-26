import 'package:flutter/material.dart';

/// Vertical spacing constants in percent.
const double _VerticalSpaceSmall = 2.5;
const double _VerticalSpaceMedium = 5.0;
const double _VerticalSpaceLarge = 10.0;

/// Horizontal spacing constants in percent.
const double _HorizontalSpaceSmall = 2.5;
const double _HorizontalSpaceMedium = 5.0;
const double _HorizontalSpaceLarge = 10.0;

/// Spacing constants in percent.
const double _SpaceSmall = 30.0;
const double _SpaceMedium = 45.0;
const double _SpaceLarge = 55.0;

/// Returns a vertical space with height set to [_VerticalSpaceSmall]
Widget verticalSpaceSmall(BuildContext context) {
  double size =
      MediaQuery.of(context).size.height * (_VerticalSpaceSmall / 100);
  return SizedBox(height: size);
}

/// Returns a vertical space with height set to [_VerticalSpaceMedium]
Widget verticalSpaceMedium(BuildContext context) {
  double size =
      MediaQuery.of(context).size.height * (_VerticalSpaceMedium / 100);
  return SizedBox(height: size);
}

/// Returns a vertical space with height set to [_VerticalSpaceLarge]
Widget verticalSpaceLarge(BuildContext context) {
  double size =
      MediaQuery.of(context).size.height * (_VerticalSpaceLarge / 100);
  return SizedBox(height: size);
}

/// Returns a vertical space equal to the [height] supplied
Widget verticalSpace(BuildContext context, double height) {
  double size = MediaQuery.of(context).size.height * (height / 100);
  return SizedBox(height: size);
}

/// Returns a horizontal space with width set to [_HorizontalSpaceSmall]
Widget horizontalSpaceSmall(BuildContext context) {
  double size =
      MediaQuery.of(context).size.width * (_HorizontalSpaceSmall / 100);
  return SizedBox(width: size);
}

/// Returns a horizontal space with width set to [_HorizontalSpaceMedium]
Widget horizontalSpaceMedium(BuildContext context) {
  double size =
      MediaQuery.of(context).size.width * (_HorizontalSpaceMedium / 100);
  return SizedBox(width: size);
}

/// Returns a horizontal space with height set to [HorizontalSpaceLarge]
Widget horizontalSpaceLarge(BuildContext context) {
  double size =
      MediaQuery.of(context).size.width * (_HorizontalSpaceLarge / 100);
  return SizedBox(width: size);
}

/// Returns a horizontal space equal to the [width] supplied
Widget horizontalSpace(BuildContext context, double width) {
  double size = MediaQuery.of(context).size.width * (width / 100);
  return SizedBox(width: size);
}

/// Returns a width based on device size set to [_SpaceSmall]
double widthSmall(BuildContext context) {
  return MediaQuery.of(context).size.width * (_SpaceSmall / 100);
}

/// Returns a width based on device size set to [_SpaceMedium]
double widthMedium(BuildContext context) {
  return MediaQuery.of(context).size.width * (_SpaceMedium / 100);
}

/// Returns a width based on device size set to [_SpaceLarge]
double widthLarge(BuildContext context) {
  return MediaQuery.of(context).size.width * (_SpaceLarge / 100);
}

/// Returns a width based on device size equal to the [width] supplied
double widthBox(BuildContext context, double width) {
  double size = width / 100;
  return MediaQuery.of(context).size.width * size;
}

/// Returns a height based on device size set to [_SpaceSmall]
double heightSmall(BuildContext context) {
  return MediaQuery.of(context).size.height * (_SpaceSmall / 100);
}

/// Returns a height based on device size set to [_SpaceMedium]
double heightMedium(BuildContext context) {
  return MediaQuery.of(context).size.height * (_SpaceMedium / 100);
}

/// Returns a height based on device size set to [_SpaceLarge]
double heightLarge(BuildContext context) {
  return MediaQuery.of(context).size.height * (_SpaceLarge / 100);
}

/// Returns a height based on device size equal to the [height] supplied
double heightBox(BuildContext context, double height) {
  double size = height / 100;
  return MediaQuery.of(context).size.height * size;
}

/// Returns an edge insets with right size equal to the [right]
EdgeInsets edgeRight(BuildContext context, double right) {
  double height = MediaQuery.of(context).size.width;

  return EdgeInsets.only(
    right: height * (right / 100),
  );
}

/// Returns an edge insets with left size equal to the [left]
EdgeInsets edgeLeft(BuildContext context, double left) {
  double height = MediaQuery.of(context).size.width;

  return EdgeInsets.only(
    left: height * (left / 100),
  );
}

/// Returns an edge insets with vertical size equal to the [vertical]
EdgeInsets edgeVertical(BuildContext context, double vertical) {
  double height = MediaQuery.of(context).size.height;

  return EdgeInsets.symmetric(
    vertical: height * (vertical / 100),
  );
}

/// Returns an edge insets with horizontal size equal to the [horizontal]
EdgeInsets edgeHorizontal(BuildContext context, double horizontal) {
  double width = MediaQuery.of(context).size.width;

  return EdgeInsets.symmetric(
    horizontal: width * (horizontal / 100),
  );
}

/// Returns an edge insets with symmetric size equal to the [horizontal] and [vertical]
EdgeInsets edgeSymmetric(
    BuildContext context, double horizontal, double vertical) {
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;

  return EdgeInsets.symmetric(
    vertical: height * (vertical / 100),
    horizontal: width * (horizontal / 100),
  );
}
