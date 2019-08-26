import 'package:edukasi_pot/core/services/api/api.dart';
import 'package:edukasi_pot/core/services/api/models.dart';

class MockApi implements Api {
  @override
  Future<User> getUser(String email, String password) async {
    await Future.delayed(Duration(seconds: 1));

    if (email == 'user1@test.com' && password == 'test') {
      return User(
        id: '1',
        name: 'Airin Rachmi',
        imageUrl: 'assets/graphics/airin.jpg',
      );
    }
    if (email == 'user2@test.com' && password == 'test') {
      return User(
        id: '2',
        name: 'Indah Putri',
        imageUrl: 'assets/graphics/indah.jpeg',
      );
    } else {
      throw ('Authentication failed');
    }
  }

  @override
  Future<List<Subject>> getSubjectsForUser(String userId) async {
    await Future.delayed(Duration(seconds: 1));

    if (userId == '1') {
      return [
        Subject(
          id: '1',
          title: 'Math & Logic',
          klass: '3A',
          startTime: DateTime.parse('2019-07-30T07:30:00Z'),
          endTime: DateTime.parse('2019-07-30T09:00:00Z'),
        ),
        Subject(
          id: '2',
          title: 'Math & Logic',
          klass: '4A',
          startTime: DateTime.parse('2019-07-30T09:30:00Z'),
          endTime: DateTime.parse('2019-07-30T11:00:00Z'),
        ),
      ];
    }

    if (userId == '2') {
      return [
        Subject(
          id: '3',
          title: 'Science',
          klass: '3A',
          startTime: DateTime.parse('2019-07-31T09:30:00Z'),
          endTime: DateTime.parse('2019-07-31T11:00:00Z'),
        ),
        Subject(
          id: '4',
          title: 'Science',
          klass: '3B',
          startTime: DateTime.parse('2019-07-31T12:30:00Z'),
          endTime: DateTime.parse('2019-07-31T14:00:00Z'),
        ),
      ];
    }

    return null;
  }

  @override
  Future<List<Module>> getModulesForSubject(String topicId) async {
    await Future.delayed(Duration(seconds: 1));

    if (topicId == '1') {
      return [
        Module(id: '1', title: 'Decimal fractions and place value patterns'),
        Module(id: '2', title: 'Multi-digit whole number place value concepts'),
        Module(id: '3', title: 'Addition and subtraction of fractions'),
        Module(id: '4', title: 'Multiplication and division of fractions'),
        Module(id: '5', title: 'Problem solving: fraction word problems'),
      ];
    }

    if (topicId == '2') {
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

    return null;
  }

  @override
  Future<List<Homework>> getHomeworksForSubject(String subjectId) async {
    await Future.delayed(Duration(seconds: 1));

    List<String> subjectIds = ['1', '2'];

    if (subjectIds.contains(subjectId)) {
      return [
        Homework(id: "1", title: 'Multiply and divide decimals by 10'),
        Homework(id: "2", title: 'Powers of ten'),
        Homework(id: "3", title: 'Multiply and divide by powers of 10'),
        Homework(
            id: "4",
            title: 'Multiply and divide decimals by 10, 100, and 1000'),
        Homework(id: "5", title: 'Compare decimal place value'),
        Homework(id: "6", title: 'Multiply and divide by powers of 10'),
      ];
    }

    return null;
  }

  @override
  Future<List<Student>> getStudentsForSubject(String subjectId) async {
    await Future.delayed(Duration(seconds: 1));

    List<String> subjectIds = ['1', '2'];

    if (subjectIds.contains(subjectId)) {
      return [
        Student(
          id: '1',
          name: 'Azka',
          imageUrl: 'assets/graphics/student1.jpeg',
        ),
        Student(
          id: '2',
          name: 'Jenifer',
          imageUrl: 'assets/graphics/student2.jpeg',
        ),
        Student(
          id: '3',
          name: 'Rayuko',
          imageUrl: 'assets/graphics/student3.jpeg',
        ),
        Student(
          id: '4',
          name: 'Sheri',
          imageUrl: 'assets/graphics/student4.jpeg',
        ),
      ];
    }

    return null;
  }
}
