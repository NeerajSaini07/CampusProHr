import 'package:campus_pro/src/DATA/API_SERVICES/updateStudentPasswordApi.dart';

abstract class UpdateStudentPasswordRespositoryAbs {
  Future<bool> updateStudent(Map<String, String?> studentData);
}

class UpdateStudentPasswordRepository
    extends UpdateStudentPasswordRespositoryAbs {
  final UpdateStudentPasswordApi _api;

  UpdateStudentPasswordRepository(this._api);
  @override
  Future<bool> updateStudent(
      Map<String, String?> studentData) async {
    final data = await _api.updateDetail(studentData);
    return data;
  }
}
