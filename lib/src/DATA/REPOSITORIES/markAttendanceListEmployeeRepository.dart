import 'package:campus_pro/src/DATA/API_SERVICES/markAttendanceListEmployeeApi.dart';
import 'package:campus_pro/src/DATA/MODELS/markAttendanceListEmployeeModel.dart';

abstract class MarkAttendanceListEmployeeRepositoryAbs {
  Future<List<MarkAttendanceListEmployeeModel>> getAttList(
      Map<String, String> requestPayload);
}

class MarkAttendanceListEmployeeRepository
    extends MarkAttendanceListEmployeeRepositoryAbs {
  final MarkAttendanceListEmployeeApi _api;
  MarkAttendanceListEmployeeRepository(this._api);

  Future<List<MarkAttendanceListEmployeeModel>> getAttList(
      Map<String, String?> requestPayload) async {
    final data = await _api.markAttendanceList(requestPayload);
    return data;
  }
}
