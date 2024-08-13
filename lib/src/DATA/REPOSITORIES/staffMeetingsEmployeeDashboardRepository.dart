import 'package:campus_pro/src/DATA/API_SERVICES/staffMeetingsEmployeeDashboardApi.dart';
import 'package:campus_pro/src/DATA/MODELS/staffMeetingsEmployeeDashboardModel.dart';

abstract class StaffMeetingsEmployeeDashboardRepositoryAbs {
  Future<List<StaffMeetingsEmployeeDashboardModel>> onlineMeetings(
      Map<String, String> meetingData);
}

class StaffMeetingsEmployeeDashboardRepository extends StaffMeetingsEmployeeDashboardRepositoryAbs {
  final StaffMeetingsEmployeeDashboardApi _api;
  StaffMeetingsEmployeeDashboardRepository(this._api);
  @override
  Future<List<StaffMeetingsEmployeeDashboardModel>> onlineMeetings(
      Map<String, String?> meetingData) async {
    final data = await _api.onlineMeetings(meetingData);
    return data;
  }
}
