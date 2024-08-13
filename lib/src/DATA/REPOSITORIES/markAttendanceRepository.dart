import 'package:campus_pro/src/DATA/API_SERVICES/assignTeacherApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/markAttendanceApi.dart';
import 'package:campus_pro/src/DATA/MODELS/assignTeacherModel.dart';

abstract class MarkAttendanceRepositoryAbs {
  Future<bool> markAttendance(Map<String, String> markData);
}

class MarkAttendanceRepository extends MarkAttendanceRepositoryAbs {
  final MarkAttendanceApi _api;
  MarkAttendanceRepository(this._api);
  @override
  Future<bool> markAttendance(Map<String, String?> markData) async {
    final data = await _api.markAttendance(markData);
    return data;
  }
}
