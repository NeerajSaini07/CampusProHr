import 'package:campus_pro/src/DATA/API_SERVICES/subjectAlloteToTeacherApi.dart';

abstract class SubjectAlloteToTeacherRepositoryAbs {
  Future<String> alloteSubject(Map<String, String?> request);
}

class SubjectAlloteToTeacherRepository
    extends SubjectAlloteToTeacherRepositoryAbs {
  final SubjectAlloteToTeacherApi _api;
  SubjectAlloteToTeacherRepository(this._api);

  Future<String> alloteSubject(Map<String, String?> request) {
    final data = _api.alloteSubject(request);
    return data;
  }
}
