import 'package:campus_pro/src/DATA/API_SERVICES/attendanceEmployeeApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/subjectListEmployeeApi.dart';
import 'package:campus_pro/src/DATA/MODELS/SubjectListEmployeeModel.dart';
import 'package:campus_pro/src/DATA/MODELS/attendanceEmployeeModel.dart';

abstract class AttendanceEmployeeRepositoryAbs {
  Future<List<AttendanceEmployeeModel>> getAttendance(
      Map<String, String> requestPayload);
}

class AttendanceEmployeeRepository extends AttendanceEmployeeRepositoryAbs {
  final AttendanceEmployeeApi _api;
  AttendanceEmployeeRepository(this._api);

  Future<List<AttendanceEmployeeModel>> getAttendance(
      Map<String, String?> requestPayload) async {
    final data = await _api.attendanceEmployee(requestPayload);
    return data;
  }
}
