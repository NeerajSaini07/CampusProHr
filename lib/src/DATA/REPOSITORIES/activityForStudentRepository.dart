import 'package:campus_pro/src/DATA/API_SERVICES/activityForStudentApi.dart';
import 'package:campus_pro/src/DATA/MODELS/activityForStudentModel.dart';

abstract class ActivityForStudentRepositoryAbs {
  Future<List<ActivityForStudentModel>> getActivity(
      Map<String, String?> request);
}

class ActivityForStudentRepository extends ActivityForStudentRepositoryAbs {
  final ActivityForStudentApi _api;
  ActivityForStudentRepository(this._api);

  Future<List<ActivityForStudentModel>> getActivity(
      Map<String, String?> request) {
    var data = _api.getActivity(request);
    return data;
  }
}
