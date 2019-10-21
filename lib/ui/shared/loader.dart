import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Loader extends StatelessWidget {

  final AlwaysStoppedAnimation<Color> loaderColor;

  const Loader({Key key, this.loaderColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoActivityIndicator()
        : CircularProgressIndicator(valueColor: loaderColor);
  }
}
