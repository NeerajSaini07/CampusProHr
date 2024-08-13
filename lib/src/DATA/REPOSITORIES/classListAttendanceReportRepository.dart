import 'package:campus_pro/src/DATA/API_SERVICES/classListAttendanceApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/classListAttendanceReportApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/classListEmployeeApi.dart';
import 'package:campus_pro/src/DATA/MODELS/classListAttendanceModel.dart';
import 'package:campus_pro/src/DATA/MODELS/classListAttendanceReportModel.dart';
import 'package:campus_pro/src/DATA/MODELS/classListEmployeeModel.dart';

abstract class ClassListAttendanceReportRepositoryAbs {
  Future<List<ClassListAttendanceReportModel>> getClass(
      Map<String, String> requestPayload);
}

class ClassListAttendanceReportRepository
    extends ClassListAttendanceReportRepositoryAbs {
  final ClassListAttendanceReportApi _api;
  ClassListAttendanceReportRepository(this._api);

  Future<List<ClassListAttendanceReportModel>> getClass(
      Map<String, String?> requestPayload) async {
    final data = await _api.getClass(requestPayload);
    return data;
  }
}
