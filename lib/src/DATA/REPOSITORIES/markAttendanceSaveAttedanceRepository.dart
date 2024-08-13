import 'package:campus_pro/src/DATA/API_SERVICES/markAttendanceSaveAttendanceEmployeeApi.dart';

abstract class MarkAttendanceSaveAttendanceEmployeeRepositoryAbs {
  Future<List> saveAttendance(Map<String, String> markData);
}

class MarkAttendanceSaveAttendanceEmployeeRepository
    extends MarkAttendanceSaveAttendanceEmployeeRepositoryAbs {
  final MarkAttendanceSaveAttendanceEmployeeApi _api;
  MarkAttendanceSaveAttendanceEmployeeRepository(this._api);
  @override
  Future<List> saveAttendance(Map<String, String?> markData) async {
    final data = await _api.saveAtt(markData);
    return data;
  }
}
