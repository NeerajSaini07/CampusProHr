import 'package:campus_pro/src/DATA/API_SERVICES/meetingDetailsAdminApi.dart';
import 'package:campus_pro/src/DATA/MODELS/meetingDetailsAdminModel.dart';

abstract class MeetingDetailsAdminRepositoryAbs {
  Future<MeetingDetailsAdminModel> meetingDetailsAdmin(Map<String, String> meetingData);
}

class MeetingDetailsAdminRepository extends MeetingDetailsAdminRepositoryAbs {
  final MeetingDetailsAdminApi _api;
  MeetingDetailsAdminRepository(this._api);
  @override
  Future<MeetingDetailsAdminModel> meetingDetailsAdmin(
      Map<String, String?> meetingData) async {
    final data = await _api.meetingDetailsAdmin(meetingData);
    return data;
  }
}
