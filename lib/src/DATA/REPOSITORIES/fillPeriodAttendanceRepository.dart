import 'package:campus_pro/src/DATA/API_SERVICES/fillPeriodAttendanceApi.dart';

abstract class FillPeriodAttendanceRepositoryAbs {
  Future<String> fillPeriod(Map<String, String?> request);
}

class FillPeriodAttendanceRepository extends FillPeriodAttendanceRepositoryAbs {
  final FillPeriodAttendanceApi _api;
  FillPeriodAttendanceRepository(this._api);

  Future<String> fillPeriod(Map<String, String?> request) {
    var data = _api.fillPeriod(request);
    return data;
  }
}
