import 'package:campus_pro/src/DATA/API_SERVICES/teachersListMeetingApi.dart';
import 'package:campus_pro/src/DATA/MODELS/teachersListMeetingModel.dart';

abstract class TeachersListMeetingRepositoryAbs {
  Future<List<TeachersListMeetingModel>> teacherList(
      Map<String, String> requestPayload);
}

class TeachersListMeetingRepository extends TeachersListMeetingRepositoryAbs {
  final TeachersListMeetingApi _api;
  TeachersListMeetingRepository(this._api);
  @override
  Future<List<TeachersListMeetingModel>> teacherList(
      Map<String, String?> requestPayload) async {
    final data = await _api.teacherList(requestPayload);
    return data;
  }
}
