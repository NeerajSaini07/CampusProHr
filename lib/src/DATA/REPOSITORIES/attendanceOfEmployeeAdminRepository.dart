import 'package:campus_pro/src/DATA/API_SERVICES/attendanceEmployeeApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/attendanceOfEmployeeAdminApi.dart';
import 'package:campus_pro/src/DATA/MODELS/SubjectListEmployeeModel.dart';
import 'package:campus_pro/src/DATA/MODELS/attendanceEmployeeModel.dart';
import 'package:campus_pro/src/DATA/MODELS/attendanceOfEmployeeAdminModel.dart';

abstract class AttendanceOfEmployeeAdminRepositoryAbs {
  Future<List<AttendanceOfEmployeeAdminModel>> getAttendance(
      Map<String, String> requestPayload);
}

class AttendanceOfEmployeeAdminRepository
    extends AttendanceOfEmployeeAdminRepositoryAbs {
  final AttendanceOfEmployeeAdminApi _api;
  AttendanceOfEmployeeAdminRepository(this._api);

  Future<List<AttendanceOfEmployeeAdminModel>> getAttendance(
      Map<String, String?> requestPayload) async {
    final data = await _api.attendanceOfEmployee(requestPayload);
    return data;
  }
}
