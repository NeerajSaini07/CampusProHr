import 'package:campus_pro/src/DATA/API_SERVICES/saveGoogleMeetScheduleMeetingAdminApi.dart';

abstract class SaveGoogleMeetScheduleMeetingAdminRespositoryAbs {
  Future<bool> scheduleMeetingAdmin(Map<String, String?> meetingData);
}

class SaveGoogleMeetScheduleMeetingAdminRepository extends SaveGoogleMeetScheduleMeetingAdminRespositoryAbs {
  final SaveGoogleMeetScheduleMeetingAdminApi _api;

  SaveGoogleMeetScheduleMeetingAdminRepository(this._api);
  @override
  Future<bool> scheduleMeetingAdmin(Map<String, String?> meetingData) async {
    final data = await _api.scheduleMeetingAdmin(meetingData);
    return data;
  }
}