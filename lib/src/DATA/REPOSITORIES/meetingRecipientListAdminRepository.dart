import 'package:campus_pro/src/DATA/API_SERVICES/meetingRecipientListAdminApi.dart';
import 'package:campus_pro/src/DATA/MODELS/meetingRecipientListAdminModel.dart';

abstract class MeetingRecipientListAdminRepositoryAbs {
  Future<List<MeetingRecipientListAdminModel>> meetingStatus(
      Map<String, String> meetingData);
}

class MeetingRecipientListAdminRepository extends MeetingRecipientListAdminRepositoryAbs {
  final MeetingRecipientListAdminApi _api;
  MeetingRecipientListAdminRepository(this._api);
  @override
  Future<List<MeetingRecipientListAdminModel>> meetingStatus(
      Map<String, String?> meetingData) async {
    final data = await _api.meetingStatus(meetingData);
    return data;
  }
}
