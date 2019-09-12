import 'dart:async';

import 'package:edukasi_pot/core/services/api/api.dart';
import 'package:edukasi_pot/core/services/api/models.dart';
import 'package:edukasi_pot/core/services/stoppable_service.dart';
import 'package:edukasi_pot/core/services/subject_service.dart';
import 'package:edukasi_pot/locator.dart';

class AuthService implements StoppableService {
  Api _api = locator<Api>();

  StreamController<User> userController = StreamController<User>();

  SubjectService _subjectsService = locator<SubjectService>();

  Future<void> authenticate(String email, String password) async {
    var fetchedUser = await _api.getUser(email, password);

    var hasUser = fetchedUser != null;

    if (hasUser) {
      /// Fetch all subjects to get subject in session
      await _subjectsService.getSubjects(fetchedUser.id);

      /// Add userData to StreamController
      userController.add(fetchedUser);
    }
  }

  @override
  bool get serviceStopped => null;

  @override
  void start() {}

  @override
  void stop() {}
}
