import 'package:edukasi_pot/core/services/api/models.dart';
import 'package:edukasi_pot/core/services/subject_service.dart';
import 'package:edukasi_pot/core/viewmodels/base_model.dart';
import 'package:edukasi_pot/locator.dart';

class SubjectModel extends BaseModel {
  SubjectService _subjectsService = locator<SubjectService>();

  List<Subject> get subjects => _subjectsService.subjects;

  Subject get subjectInSession => _subjectsService.subjectInSession;

  Future getSubjects(String userId) async {
    await _subjectsService.getSubjects(userId);
  }

  void addSubjectToStream(Subject subject) {
    _subjectsService.addSubjectToStream(subject);
  }
}
