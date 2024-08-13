import 'package:campus_pro/src/DATA/API_SERVICES/activityApi.dart';
import 'package:campus_pro/src/DATA/MODELS/activityModel.dart';

abstract class ActivityRepositoryAbs {
  Future<List<ActivityModel>> showActivityData(
      Map<String, String> requestPayload);
}

class ActivityRepository extends ActivityRepositoryAbs {
  final ActivityApi _api;
  ActivityRepository(this._api);
  @override
  Future<List<ActivityModel>> showActivityData(
      Map<String, String?> requestPayload) async {
    final data = await _api.activityData(requestPayload);
    return data;
  }
}
