import 'package:edukasi_pot/providers/homework.dart';
import 'package:flutter/foundation.dart';

class Homeworks with ChangeNotifier {
  List<Homework> _items = [
    Homework(title: 'Multiply and divide decimals by 10'),
    Homework(title: 'Powers of ten'),
    Homework(title: 'Multiply and divide by powers of 10'),
    Homework(title: 'Multiply and divide decimals by 10, 100, and 1000'),
    Homework(title: 'Compare decimal place value'),
    Homework(title: 'Multiply and divide by powers of 10'),
  ];

  List<Homework> get item {
    return [..._items];
  }
}
