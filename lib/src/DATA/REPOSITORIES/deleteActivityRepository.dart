import 'package:campus_pro/src/DATA/API_SERVICES/deleteActivityApi.dart';

abstract class DeleteActivityRepositoryAbs {
  Future<String> deleteActivity(Map<String, String?> request);
}

class DeleteActivityRepository extends DeleteActivityRepositoryAbs {
  final DeleteActivityApi _api;
  DeleteActivityRepository(this._api);

  Future<String> deleteActivity(Map<String, String?> request) {
    var data = _api.deleteApi(request);
    return data;
  }
}
