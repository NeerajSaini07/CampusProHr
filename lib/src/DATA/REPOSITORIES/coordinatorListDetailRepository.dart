import 'package:campus_pro/src/DATA/API_SERVICES/coordinatorListDetailApi.dart';
import 'package:campus_pro/src/DATA/MODELS/coordinatorListDetailModel.dart';

abstract class CoordinatorListDetailRepositoryAbs {
  Future<List<CoordinatorListDetailModel>> getCoordinator(
      Map<String, String?> request);
}

class CoordinatorListDetailRepository
    extends CoordinatorListDetailRepositoryAbs {
  final CoordinatorListDetailApi _api;

  CoordinatorListDetailRepository(this._api);

  Future<List<CoordinatorListDetailModel>> getCoordinator(
      Map<String, String?> request) {
    var data = _api.getCoordinator(request);
    return data;
  }
}
