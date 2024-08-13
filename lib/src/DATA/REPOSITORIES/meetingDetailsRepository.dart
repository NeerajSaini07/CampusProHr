import 'package:campus_pro/src/DATA/API_SERVICES/meetingDetailsApi.dart';
import 'package:campus_pro/src/DATA/MODELS/meetingDetailsModel.dart';

abstract class MeetingDetailsRepositoryAbs {
  Future<MeetingDetailsModel> meetingDetails(Map<String, String> meetingData);
}

class MeetingDetailsRepository extends MeetingDetailsRepositoryAbs {
  final MeetingDetailsApi _api;
  MeetingDetailsRepository(this._api);
  @override
  Future<MeetingDetailsModel> meetingDetails(
      Map<String, String?> meetingData) async {
    final data = await _api.meetingDetails(meetingData);
    return data;
  }
}
