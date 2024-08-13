import 'package:campus_pro/src/DATA/API_SERVICES/deleteCoordinatorApi.dart';

abstract class DeleteCoordinatorRepositoryAbs {
  Future<String> deleteCoordinator(Map<String, String?> request);
}

class DeleteCoordinatorRepository extends DeleteCoordinatorRepositoryAbs {
  final DeleteCoordinatorApi _api;

  DeleteCoordinatorRepository(this._api);
  Future<String> deleteCoordinator(Map<String, String?> request) {
    var data = _api.deleteCoordinator(request);
    return data;
  }
}
