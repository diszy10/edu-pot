import 'package:flutter/foundation.dart';

class Student with ChangeNotifier {
  final String name, className, image;

  Student({
    @required this.name,
    @required this.className,
    @required this.image,
  });
}
