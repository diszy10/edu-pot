import 'package:flutter/foundation.dart';

class Student with ChangeNotifier {
  final String name, className, image;
  bool isAbsent;
  bool isAttend;

  Student({
    @required this.name,
    @required this.className,
    @required this.image,
    this.isAbsent = false,
    this.isAttend = false,
  });

  void toggleAbsent() {
    isAbsent = !isAbsent;
    notifyListeners();
  }

  void toggleAttend() {
    isAttend = !isAttend;
    notifyListeners();
  }
}
