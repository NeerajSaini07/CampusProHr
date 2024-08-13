import 'package:campus_pro/src/DATA/API_SERVICES/saveScheduleMeetingApi.dart';

abstract class SaveScheduleMeetingRepositoryAbs {
  Future<bool> saveMeeting(Map<String, String> meetingData);
}

class SaveScheduleMeetingRepository extends SaveScheduleMeetingRepositoryAbs {
  final SaveScheduleMeetingApi _api;
  SaveScheduleMeetingRepository(this._api);
  @override
  Future<bool> saveMeeting(Map<String, String?> meetingData) async {
    final data = await _api.saveMeeting(meetingData);
    return data;
  }
}
