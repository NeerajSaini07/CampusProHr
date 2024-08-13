import 'package:campus_pro/src/DATA/API_SERVICES/homeWorkStudentApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/studentLeaveEmployeeApi.dart';
import 'package:campus_pro/src/DATA/MODELS/homeWorkStudentModel.dart';
import 'package:campus_pro/src/DATA/MODELS/studentLeaveEmployeeModel.dart';

abstract class StudentLeaveEmployeeRepositoryAbs {
  Future<List<StudentLeaveEmployeeModel>> studentLeave(
      Map<String, String> requestPayload);
}

class StudentLeaveEmployeeRepository extends StudentLeaveEmployeeRepositoryAbs {
  final StudentLeaveEmployeeApi _api;
  StudentLeaveEmployeeRepository(this._api);

  Future<List<StudentLeaveEmployeeModel>> studentLeave(
      Map<String, String?> requestPayload) async {
    final data = await _api.leaveApi(requestPayload);
    return data;
  }
}
