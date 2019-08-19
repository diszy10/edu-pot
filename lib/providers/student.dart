import 'package:flutter/foundation.dart';

class Student with ChangeNotifier {
  final String name, className, image;
  bool isAbsent;

  Student({
    @required this.name,
    @required this.className,
    @required this.image,
    this.isAbsent = false,
  });

  void toggleAbsent() {
    isAbsent = !isAbsent;
    notifyListeners();
  }
}
