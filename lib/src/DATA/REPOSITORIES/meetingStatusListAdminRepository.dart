import 'package:campus_pro/src/DATA/API_SERVICES/meetingStatusListAdminApi.dart';
import 'package:campus_pro/src/DATA/MODELS/meetingStatusListAdminModel.dart';

abstract class MeetingStatusListAdminRepositoryAbs {
  Future<List<MeetingStatusListAdminModel>> meetingStatus(
      Map<String, String> meetingData);
}

class MeetingStatusListAdminRepository extends MeetingStatusListAdminRepositoryAbs {
  final MeetingStatusListAdminApi _api;
  MeetingStatusListAdminRepository(this._api);
  @override
  Future<List<MeetingStatusListAdminModel>> meetingStatus(
      Map<String, String?> meetingData) async {
    final data = await _api.meetingStatus(meetingData);
    return data;
  }
}
