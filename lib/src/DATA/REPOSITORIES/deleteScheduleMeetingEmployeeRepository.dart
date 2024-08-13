import 'package:campus_pro/src/DATA/API_SERVICES/deleteScheduleMeetingEmployeeApi.dart';

abstract class DeleteScheduleMeetingEmployeeRepositoryAbs {
  Future<bool> deleteMeeting(Map<String, String> meetingData);
}

class DeleteScheduleMeetingEmployeeRepository
    extends DeleteScheduleMeetingEmployeeRepositoryAbs {
  final DeleteScheduleMeetingEmployeeApi _api;
  DeleteScheduleMeetingEmployeeRepository(this._api);
  @override
  Future<bool> deleteMeeting(Map<String, String?> meetingData) async {
    final data = await _api.deleteMeeting(meetingData);
    return data;
  }
}
