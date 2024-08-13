import 'package:campus_pro/src/DATA/API_SERVICES/saveGoogleMeetScheduleMeetingApi.dart';

abstract class SaveGoogleMeetScheduleMeetingRespositoryAbs {
  Future<bool> scheduleMeeting(Map<String, String> meetingData);
}

class SaveGoogleMeetScheduleMeetingRepository extends SaveGoogleMeetScheduleMeetingRespositoryAbs {
  final SaveGoogleMeetScheduleMeetingApi _api;

  SaveGoogleMeetScheduleMeetingRepository(this._api);
  @override
  Future<bool> scheduleMeeting(Map<String, String> meetingData) async {
    final data = await _api.scheduleMeeting(meetingData);
    return data;
  }
}