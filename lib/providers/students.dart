import 'package:edukasi_pot/providers/student.dart';
import 'package:flutter/foundation.dart';

class Students with ChangeNotifier {
  List<Student> items = [
    Student(
      name: 'Azka',
      className: '5A',
      image: 'assets/graphics/student1.jpeg',
    ),
    Student(
      name: 'Jenifer',
      className: '5A',
      image: 'assets/graphics/student2.jpeg',
    ),
    Student(
      name: 'Rayuko',
      className: '5A',
      image: 'assets/graphics/student3.jpeg',
    ),
    Student(
      name: 'Sheri',
      className: '5A',
      image: 'assets/graphics/student4.jpeg',
    ),
  ];
}
