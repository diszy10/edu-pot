import 'package:flutter/foundation.dart';

class Homework with ChangeNotifier {
  final String id, title;
  bool isDistribute;

  Homework({@required this.id, @required this.title, this.isDistribute = false});

  void toggleDistribute() {
    isDistribute = !isDistribute;
    notifyListeners();
  }
}
