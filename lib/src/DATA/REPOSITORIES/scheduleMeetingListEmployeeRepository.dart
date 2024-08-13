import 'package:campus_pro/src/DATA/API_SERVICES/scheduleMeetingListEmployeeApi.dart';
import 'package:campus_pro/src/DATA/MODELS/scheduleMeetingListEmployeeModel.dart';

abstract class ScheduleMeetingListEmployeeRepositoryAbs {
  Future<List<ScheduleMeetingListEmployeeModel>> meetingList(
      Map<String, String> meetingData);
}

class ScheduleMeetingListEmployeeRepository
    extends ScheduleMeetingListEmployeeRepositoryAbs {
  final ScheduleMeetingListEmployeeApi _api;
  ScheduleMeetingListEmployeeRepository(this._api);
  @override
  Future<List<ScheduleMeetingListEmployeeModel>> meetingList(
      Map<String, String?> meetingData) async {
    final data = await _api.meetingList(meetingData);
    return data;
  }
}
