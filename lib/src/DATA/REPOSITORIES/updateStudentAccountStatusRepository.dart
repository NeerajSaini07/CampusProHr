import 'package:campus_pro/src/DATA/API_SERVICES/studentActiveDeactiveListAdminApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/updateStudentAccountStatusApi.dart';

abstract class UpdateStudentAccountStatusRespositoryAbs {
  Future<bool> updateStudent(Map<String, String?> studentData);
}

class UpdateStudentAccountStatusRepository
    extends UpdateStudentAccountStatusRespositoryAbs {
  final UpdateStudentAccountStatusApi _api;

  UpdateStudentAccountStatusRepository(this._api);
  @override
  Future<bool> updateStudent(
      Map<String, String?> studentData) async {
    final data = await _api.updateDetail(studentData);
    return data;
  }
}
