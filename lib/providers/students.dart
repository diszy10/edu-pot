import 'package:edukasi_pot/providers/student.dart';
import 'package:flutter/foundation.dart';

class Students with ChangeNotifier {
  List<Student> items = [
    Student(
      name: 'Azka',
      className: '5A',
      image:
          'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
    ),
    Student(
      name: 'Jenifer',
      className: '5A',
      image:
          'https://images.unsplash.com/photo-1514846326710-096e4a8035e0?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
    ),
    Student(
      name: 'Rayuko',
      className: '5A',
      image:
          'https://images.unsplash.com/photo-1475823678248-624fc6f85785?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
    ),
    Student(
      name: 'Sheri',
      className: '5A',
      image:
          'https://images.unsplash.com/photo-1563978531765-159942fd0f1f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
    ),
  ];
}
