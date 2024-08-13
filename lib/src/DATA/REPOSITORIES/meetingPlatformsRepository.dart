import 'package:campus_pro/src/DATA/API_SERVICES/meetingPlatformsApi.dart';
import 'package:campus_pro/src/DATA/MODELS/meetingPlatformsModel.dart';

abstract class MeetingPlatformsRepositoryAbs {
  Future<List<MeetingPlatformsModel>> meetingPlatforms(
      Map<String, String> platformData);
}

class MeetingPlatformsRepository extends MeetingPlatformsRepositoryAbs {
  final MeetingPlatformsApi _api;
  MeetingPlatformsRepository(this._api);
  @override
  Future<List<MeetingPlatformsModel>> meetingPlatforms(
      Map<String, String?> platformData) async {
    final data = await _api.meetingPlatforms(platformData);
    return data;
  }
}
