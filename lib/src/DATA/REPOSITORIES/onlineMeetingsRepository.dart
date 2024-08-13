import 'package:campus_pro/src/DATA/API_SERVICES/assignTeacherApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/onlineMeetingsApi.dart';
import 'package:campus_pro/src/DATA/MODELS/assignTeacherModel.dart';
import 'package:campus_pro/src/DATA/MODELS/onlineMeetingsModel.dart';

abstract class OnlineMeetingsRepositoryAbs {
  Future<List<OnlineMeetingsModel>> onlineMeetings(
      Map<String, String> meetingData);
}

class OnlineMeetingsRepository extends OnlineMeetingsRepositoryAbs {
  final OnlineMeetingsApi _api;
  OnlineMeetingsRepository(this._api);
  @override
  Future<List<OnlineMeetingsModel>> onlineMeetings(
      Map<String, String?> meetingData) async {
    final data = await _api.onlineMeetings(meetingData);
    return data;
  }
}
