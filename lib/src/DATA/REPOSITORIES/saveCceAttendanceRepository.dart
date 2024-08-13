import 'package:campus_pro/src/DATA/API_SERVICES/saveCceAttendanceApi.dart';

abstract class SaveCceAttendanceRepositoryAbs {
  Future<String> saveCceAttendance(Map<String, String?> request);
}

class SaveCceAttendanceRepository extends SaveCceAttendanceRepositoryAbs {
  final SaveCceAttendanceApi _api;

  SaveCceAttendanceRepository(this._api);

  Future<String> saveCceAttendance(Map<String, String?> request) {
    var data = _api.saveCceAttendance(request);
    return data;
  }
}
