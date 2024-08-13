import 'package:campus_pro/src/DATA/API_SERVICES/activityApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/attendanceGraphApi.dart';
import 'package:campus_pro/src/DATA/MODELS/activityModel.dart';
import 'package:campus_pro/src/DATA/MODELS/attendanceGraphModel.dart';

abstract class AttendanceGraphRepositoryAbs {
  Future<List<AttendanceGraphModel>> attendanceGraph(
      Map<String, String> userData);
}

class AttendanceGraphRepository extends AttendanceGraphRepositoryAbs {
  final AttendanceGraphApi _api;
  AttendanceGraphRepository(this._api);
  @override
  Future<List<AttendanceGraphModel>> attendanceGraph(
      Map<String, String?> userData) async {
    final data = await _api.attendanceGraph(userData);
    return data;
  }
}
