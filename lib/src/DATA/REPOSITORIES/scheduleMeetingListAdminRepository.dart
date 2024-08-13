import 'package:campus_pro/src/DATA/API_SERVICES/scheduleMeetingListAdminApi.dart';
import 'package:campus_pro/src/DATA/MODELS/scheduleMeetingListAdminModel.dart';

abstract class ScheduleMeetingListAdminRepositoryAbs {
  Future<List<ScheduleMeetingListAdminModel>> meetingList(
      Map<String, String> meetingData);
}

class ScheduleMeetingListAdminRepository
    extends ScheduleMeetingListAdminRepositoryAbs {
  final ScheduleMeetingListAdminApi _api;
  ScheduleMeetingListAdminRepository(this._api);
  @override
  Future<List<ScheduleMeetingListAdminModel>> meetingList(
      Map<String, String?> meetingData) async {
    final data = await _api.meetingList(meetingData);
    return data;
  }
}
