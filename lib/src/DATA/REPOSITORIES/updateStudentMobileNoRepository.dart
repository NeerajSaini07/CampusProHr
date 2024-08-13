import 'package:campus_pro/src/DATA/API_SERVICES/studentActiveDeactiveListAdminApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/updateStudentMobileNoApi.dart';

abstract class UpdateStudentMobileNoRespositoryAbs {
  Future<bool> updateStudent(Map<String, String?> studentData);
}

class UpdateStudentMobileNoRepository
    extends UpdateStudentMobileNoRespositoryAbs {
  final UpdateStudentMobileNoApi _api;

  UpdateStudentMobileNoRepository(this._api);
  @override
  Future<bool> updateStudent(
      Map<String, String?> studentData) async {
    final data = await _api.updateDetail(studentData);
    return data;
  }
}
