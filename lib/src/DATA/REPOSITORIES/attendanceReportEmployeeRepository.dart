import 'package:campus_pro/src/DATA/API_SERVICES/attendanceReportEmployeeApi.dart';
import 'package:campus_pro/src/DATA/MODELS/attendanceReportEmployeeModel.dart';

abstract class AttendanceReportEmployeeRepositoryAbs {
  Future<List<AttendanceReportEmployeeModel>> getAttendanceReport(
      Map<String, String> requestPayload);
}

class AttendanceReportEmployeeRepository
    extends AttendanceReportEmployeeRepositoryAbs {
  final AttendanceReportEmployeeApi _api;
  AttendanceReportEmployeeRepository(this._api);

  Future<List<AttendanceReportEmployeeModel>> getAttendanceReport(
      Map<String, String?> requestPayload) async {
    final data = await _api.attendanceReport(requestPayload);
    return data;
  }
}
