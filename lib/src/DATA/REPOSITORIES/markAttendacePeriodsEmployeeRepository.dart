import 'package:campus_pro/src/DATA/API_SERVICES/markAttendacePeriodsEmployeeApi.dart';
import 'package:campus_pro/src/DATA/MODELS/markAttendacePeriodsEmployeeModel.dart';

abstract class MarkAttendancePeriodsEmployeeRepositoryAbs {
  Future<List<MarkAttendacePeriodsEmployeeModel>> getPeriods(
      Map<String, String> requestPayload, int? number);
}

class MarkAttendancePeriodsEmployeeRepository
    extends MarkAttendancePeriodsEmployeeRepositoryAbs {
  final MarkAttendancePeriodsEmployeeApi _api;
  MarkAttendancePeriodsEmployeeRepository(this._api);

  Future<List<MarkAttendacePeriodsEmployeeModel>> getPeriods(
      Map<String, String?> requestPayload, int? number) async {
    final data = await _api.getPeriod(requestPayload, number);
    return data;
  }
}
