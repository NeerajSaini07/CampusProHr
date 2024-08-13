import 'package:campus_pro/src/DATA/API_SERVICES/attendanceReportEmployeeApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/classListAttendanceReportAdminApi.dart';
import 'package:campus_pro/src/DATA/MODELS/attendanceReportEmployeeModel.dart';
import 'package:campus_pro/src/DATA/MODELS/classListAttendanceReportAdminModel.dart';

abstract class ClassListAttendanceReportAdminRepositoryAbs {
  Future<List<ClassListAttendanceReportAdminModel>> getClass(
      Map<String, String> requestPayload);
}

class ClassListAttendanceReportAdminRepository
    extends ClassListAttendanceReportAdminRepositoryAbs {
  final ClassListAttendanceReportAdminApi _api;
  ClassListAttendanceReportAdminRepository(this._api);

  Future<List<ClassListAttendanceReportAdminModel>> getClass(
      Map<String, String?> requestPayload) async {
    final data = await _api.getClass(requestPayload);
    return data;
  }
}
