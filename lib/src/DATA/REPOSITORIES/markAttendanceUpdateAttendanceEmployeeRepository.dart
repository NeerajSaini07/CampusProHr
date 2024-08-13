import 'package:campus_pro/src/DATA/API_SERVICES/markAttendanceSaveAttendanceEmployeeApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/markAttendanceUpdateAttendanceEmployeeApi.dart';

abstract class MarkAttendanceUpdateAttendanceEmployeeRepositoryAbs {
  Future<List> updateAttendance(Map<String, String> markData);
}

class MarkAttendanceUpdateAttendanceEmployeeRepository
    extends MarkAttendanceUpdateAttendanceEmployeeRepositoryAbs {
  final MarkAttendanceUpdateAttendanceEmployeeApi _api;
  MarkAttendanceUpdateAttendanceEmployeeRepository(this._api);
  @override
  Future<List> updateAttendance(Map<String, String?> markData) async {
    final data = await _api.updateAttendance(markData);
    return data;
  }
}
