import 'package:campus_pro/src/DATA/API_SERVICES/assignClassTeacherAdminApi.dart';

abstract class AssignClassTeacherAdminRepositoryAbs {
  Future<String> assignClassTeacher(Map<String, String?> request);
}

class AssignClassTeacherAdminRepository
    extends AssignClassTeacherAdminRepositoryAbs {
  final AssignClassTeacherAdminApi _api;
  AssignClassTeacherAdminRepository(this._api);
  Future<String> assignClassTeacher(Map<String, String?> request) {
    final data = _api.assignClassTeacher(request);
    return data;
  }
}
