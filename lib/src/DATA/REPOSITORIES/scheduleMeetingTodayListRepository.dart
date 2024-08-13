import 'package:campus_pro/src/DATA/API_SERVICES/scheduleMeetingTodayListApi.dart';
import 'package:campus_pro/src/DATA/MODELS/scheduleMeetingTodayListModel.dart';

abstract class ScheduleMeetingTodayListRepositoryAbs {
  Future<List<ScheduleMeetingTodayListModel>> meetingList(
      Map<String, String> meetingData);
}

class ScheduleMeetingTodayListRepository
    extends ScheduleMeetingTodayListRepositoryAbs {
  final ScheduleMeetingTodayListApi _api;
  ScheduleMeetingTodayListRepository(this._api);
  @override
  Future<List<ScheduleMeetingTodayListModel>> meetingList(
      Map<String, String?> meetingData) async {
    final data = await _api.meetingList(meetingData);
    return data;
  }
}
