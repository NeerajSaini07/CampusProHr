import 'package:campus_pro/src/DATA/API_SERVICES/attendanceDetailApi.dart';
import 'package:campus_pro/src/DATA/MODELS/attendanceDetailModel.dart';

abstract class AttendanceDetailRepositoryAbs {
  Future<List<AttendanceDetailModel>> getAttendanceDetail(
      Map<String, String> requestPayload);
}

class AttendanceDetailRepository extends AttendanceDetailRepositoryAbs {
  final AttendanceDetailApi _api;
  AttendanceDetailRepository(this._api);

  Future<List<AttendanceDetailModel>> getAttendanceDetail(
      Map<String, String?> requestPayload) async {
    final data = await _api.attendanceDetail(requestPayload);
    return data;
  }
}
