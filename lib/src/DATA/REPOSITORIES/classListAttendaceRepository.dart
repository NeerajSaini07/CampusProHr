import 'package:campus_pro/src/DATA/API_SERVICES/classListAttendanceApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/classListEmployeeApi.dart';
import 'package:campus_pro/src/DATA/MODELS/classListAttendanceModel.dart';
import 'package:campus_pro/src/DATA/MODELS/classListAttendanceReportModel.dart';
import 'package:campus_pro/src/DATA/MODELS/classListEmployeeModel.dart';

abstract class ClassListAttendanceRepositoryAbs {
  Future<List<ClassListAttendanceModel>> getClass(
      Map<String, String> requestPayload);
}

class ClassListAttendanceRepository extends ClassListAttendanceRepositoryAbs {
  final ClassListAttendanceApi _api;
  ClassListAttendanceRepository(this._api);

  Future<List<ClassListAttendanceModel>> getClass(
      Map<String, String?> requestPayload) async {
    final data = await _api.getClass(requestPayload);
    return data;
  }
}
