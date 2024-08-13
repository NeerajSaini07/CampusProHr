import 'package:campus_pro/src/DATA/API_SERVICES/checkAppRestrictionApi.dart';

abstract class CheckAppRestrictionRepositoryAbs {
  Future<bool> checkAppRestriction(Map<String, String> meetingData);
}

class CheckAppRestrictionRepository extends CheckAppRestrictionRepositoryAbs {
  final CheckAppRestrictionApi _api;
  CheckAppRestrictionRepository(this._api);
  @override
  Future<bool> checkAppRestriction(Map<String, String?> meetingData) async {
    final data = await _api.checkAppRestriction(meetingData);
    return data;
  }
}
