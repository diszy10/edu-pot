import 'package:edukasi_pot/core/services/api/api.dart';
import 'package:edukasi_pot/core/services/api/models.dart';

class MockApi implements Api {
  @override
  Future<User> getUser(String email, String password) async {
    await Future.delayed(Duration(seconds: 1));

    if (email == 'user1@test.com' && password == 'test') {
      return User(
        id: 1,
        name: 'Airin Rachmi',
        imageUrl: 'assets/images/airin.jpg',
      );
    }
    if (email == 'user2@test.com' && password == 'test') {
      return User(
        id: 2,
        name: 'Indah Putri',
        imageUrl: 'assets/images/indah.jpeg',
      );
    } else {
      throw ('Authentication failed');
    }
  }

  @override
  Future<List<Subject>> getSubjectsForUser(int userId) async {
    await Future.delayed(Duration(seconds: 1));

    if (userId == 1) {
      return [
        Subject(
          id: 1,
          title: 'Math & Logic',
          klass: '5A',
          startTime: DateTime.parse('2019-07-30T07:30:00Z'),
          endTime: DateTime.parse('2019-07-30T09:00:00Z'),
        ),
        Subject(
          id: 2,
          title: 'Math & Logic',
          klass: '5B',
          startTime: DateTime.parse('2019-07-30T09:30:00Z'),
          endTime: DateTime.parse('2019-07-30T11:00:00Z'),
        ),
      ];
    }

    if (userId == 2) {
      return [
        Subject(
          id: 3,
          title: 'Science',
          klass: '3A',
          startTime: DateTime.parse('2019-07-31T09:30:00Z'),
          endTime: DateTime.parse('2019-07-31T11:00:00Z'),
        ),
        Subject(
          id: 4,
          title: 'Science',
          klass: '4B',
          startTime: DateTime.parse('2019-07-31T12:30:00Z'),
          endTime: DateTime.parse('2019-07-31T14:00:00Z'),
        ),
      ];
    }

    return null;
  }

  @override
  Future<List<Module>> getModulesForSubject(int subjectId) async {
    await Future.delayed(Duration(seconds: 1));

    if (subjectId == 1) {
      return [
        Module(id: '1', title: 'Decimal fractions and place value patterns'),
        Module(id: '2', title: 'Multi-digit whole number place value concepts'),
        Module(id: '3', title: 'Addition and subtraction of fractions'),
        Module(id: '4', title: 'Multiplication and division of fractions'),
        Module(id: '5', title: 'Problem solving: fraction word problems'),
      ];
    }

    if (subjectId == 2) {
      return [
        Module(id: '1', title: 'Place value and rounding'),
        Module(id: '2', title: 'Writing whole numbers in expanded form'),
        Module(id: '3', title: 'Addition, subtraction, and estimation'),
        Module(id: '4', title: 'Factors, multiples and patterns'),
        Module(id: '5', title: 'Equivalent fractions and comparing fractions'),
        Module(id: '6', title: 'Add and subtract fractions'),
        Module(
            id: '7',
            title: 'Adding and subtracting fractions with like denominators'),
        Module(id: '8', title: 'Fractions with denominators of 10 and 100'),
        Module(id: '9', title: 'Multiplying whole numbers and fractions'),
      ];
    }

    if (subjectId == 3) {
      return [
        Module(id: '1', title: 'Classify fruits and vegetables as plant parts'),
        Module(id: '2', title: 'Identify plant parts and their functions'),
        Module(id: '3', title: 'How do plants make food?'),
        Module(
            id: '4',
            title: 'Read and construct flowering plant life cycle diagrams'),
        Module(id: '5', title: 'How do flowering plants make new plants?'),
      ];
    }

    if (subjectId == 4) {
      return [
        Module(id: '1', title: 'Read animal life cycle diagrams'),
        Module(id: '2', title: 'Construct animal life cycle diagrams'),
        Module(id: '3', title: 'Compare stages of an animal\'s life cycle'),
        Module(id: '4', title: 'Compare different animals\' life cycle'),
        Module(
            id: '5',
            title: 'Benefits of group behavior: North American caribou'),
        Module(id: '6', title: 'Benefits of group behavior: African wild dogs'),
        Module(id: '7', title: 'Benefits of group behavior: leaf-cutter ants'),
      ];
    }

    return null;
  }

  @override
  Future<List<Homework>> getHomeworksForSubject(int subjectId) async {
    await Future.delayed(Duration(seconds: 1));

    List<int> subjectIds = [1, 2];

    if (subjectIds.contains(subjectId)) {
      return [
        Homework(id: 1, title: 'Multiply and divide decimals by 10'),
        Homework(id: 2, title: 'Powers of ten'),
        Homework(id: 3, title: 'Multiply and divide by powers of 10'),
        Homework(
            id: 4, title: 'Multiply and divide decimals by 10, 100, and 1000'),
        Homework(id: 5, title: 'Compare decimal place value'),
        Homework(id: 6, title: 'Multiply and divide by powers of 10'),
      ];
    }

    if (subjectId == 3) {
      return [
        Homework(id: 1, title: 'Classify fruits and vegetables as plant parts'),
        Homework(id: 2, title: 'Identify plant parts and their functions'),
        Homework(id: 3, title: 'How do plants make food?'),
        Homework(
            id: 4,
            title: 'Read and construct flowering plant life cycle diagrams'),
        Homework(id: 5, title: 'How do flowering plants make new plants?'),
      ];
    }

    if (subjectId == 4) {
      return [
        Homework(id: 6, title: 'Read animal life cycle diagrams'),
        Homework(id: 7, title: 'Construct animal life cycle diagrams'),
        Homework(id: 8, title: 'Compare stages of an animal\'s life cycle'),
        Homework(id: 9, title: 'Compare different animals\' life cycle'),
        Homework(
            id: 10,
            title: 'Benefits of group behavior: North American caribou'),
        Homework(
            id: 11, title: 'Benefits of group behavior: African wild dogs'),
        Homework(id: 12, title: 'Benefits of group behavior: leaf-cutter ants'),
      ];
    }

    return null;
  }

  @override
  Future<List<Student>> getStudentsForSubject(int subjectId) async {
    await Future.delayed(Duration(seconds: 1));

    List<int> subjectIds = [1, 2, 3, 4];

    if (subjectIds.contains(subjectId)) {
      return [
        Student(
          id: 1,
          name: 'Alano Nilles',
          imageUrl: 'assets/images/alano.jpeg',
        ),
        Student(
          id: 2,
          name: 'Dennis Kusuma',
          imageUrl: 'assets/images/dennis.jpeg',
        ),
        Student(
          id: 3,
          name: 'Gina Ulva Pratiwi',
          imageUrl: 'assets/images/gina.jpeg',
        ),
        Student(
          id: 4,
          name: 'Jenifer Prastuti',
          imageUrl: 'assets/images/jennifer.jpeg',
        ),
        Student(
          id: 5,
          name: 'Lisa Savina',
          imageUrl: 'assets/images/lisa.jpeg',
        ),
        Student(
          id: 6,
          name: 'Olumide Adegoke',
          imageUrl: 'assets/images/olumide.jpeg',
        ),
        Student(
          id: 7,
          name: 'Rayuko Inoue',
          imageUrl: 'assets/images/rayuko.jpeg',
        ),
        Student(
          id: 8,
          name: 'Sheri Tami Riyanti',
          imageUrl: 'assets/images/sheri.jpeg',
        ),
      ];
    }

    return null;
  }
}
