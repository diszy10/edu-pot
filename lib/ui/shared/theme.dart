import 'package:edukasi_pot/ui/shared/colors.dart';
import 'package:flutter/material.dart';

final ThemeData themeData = _buildTheme();

ThemeData _buildTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    primaryColor: deepBlue,
    // textTheme: _buildTextTheme(base.textTheme),
  );
}

// TextTheme _buildTextTheme(TextTheme base) {
//   return base.copyWith(
//     headline: base.headline.copyWith(
//       fontFamily: 'Playfair',
//       fontSize: 36.0,
//       fontWeight: FontWeight.w700,
//     ),
//     subhead: base.subhead.copyWith(
//       fontFamily: 'Playfair',
//       fontSize: 24.0,
//     ),
//     title: base.title.copyWith(
//       fontFamily: 'Playfair',
//       fontSize: 20.0,
//       fontWeight: FontWeight.w700,
//     ),
//     subtitle: base.subtitle.copyWith(
//       fontFamily: 'Playfair',
//       fontSize: 18.0,
//     ),
//     body1: base.body1.copyWith(
//       fontFamily: 'NunitoSans',
//       fontSize: 16.0,
//     ),
//     body2: base.body1.copyWith(
//       fontFamily: 'Playfair',
//       fontSize: 16.0,
//     ),
//     caption: base.caption.copyWith(
//       fontFamily: 'NunitoSans',
//       fontSize: 14.0,
//     ),
//     button: base.caption.copyWith(
//       fontFamily: 'NunitoSans',
//       fontSize: 16.0,
//       color: Colors.white,
//     ),
//   );
// }
