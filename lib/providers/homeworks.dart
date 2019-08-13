import 'package:edukasi_pot/providers/homework.dart';
import 'package:flutter/foundation.dart';

class Homeworks with ChangeNotifier {
  List<Homework> _items = [
    Homework(id: "1", title: 'Multiply and divide decimals by 10'),
    Homework(id: "2", title: 'Powers of ten'),
    Homework(id: "3", title: 'Multiply and divide by powers of 10'),
    Homework(id: "4", title: 'Multiply and divide decimals by 10, 100, and 1000'),
    Homework(id: "5", title: 'Compare decimal place value'),
    Homework(id: "6", title: 'Multiply and divide by powers of 10'),
  ];

  List<Homework> get item {
    return [..._items];
  }

  Homework findById(String id) {
    return _items.firstWhere((item) => item.id == id);
  }
}
