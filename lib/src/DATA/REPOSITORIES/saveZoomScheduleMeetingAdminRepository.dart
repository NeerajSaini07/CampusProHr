import 'package:campus_pro/src/DATA/API_SERVICES/saveZoomScheduleMeetingAdminApi.dart';

abstract class SaveZoomScheduleMeetingAdminRespositoryAbs {
  Future<bool> scheduleMeetingAdmin(Map<String, String?> meetingData);
}

class SaveZoomScheduleMeetingAdminRepository extends SaveZoomScheduleMeetingAdminRespositoryAbs {
  final SaveZoomScheduleMeetingAdminApi _api;

  SaveZoomScheduleMeetingAdminRepository(this._api);
  @override
  Future<bool> scheduleMeetingAdmin(Map<String, String?> meetingData) async {
    final data = await _api.scheduleMeetingAdmin(meetingData);
    return data;
  }
}