import 'package:campus_pro/src/DATA/API_SERVICES/saveZoomScheduleMeetingApi.dart';

abstract class SaveZoomScheduleMeetingRespositoryAbs {
  Future<bool> scheduleMeeting(Map<String, String?> meetingData);
}

class SaveZoomScheduleMeetingRepository extends SaveZoomScheduleMeetingRespositoryAbs {
  final SaveZoomScheduleMeetingApi _api;

  SaveZoomScheduleMeetingRepository(this._api);
  @override
  Future<bool> scheduleMeeting(Map<String, String?> meetingData) async {
    final data = await _api.scheduleMeeting(meetingData);
    return data;
  }
}