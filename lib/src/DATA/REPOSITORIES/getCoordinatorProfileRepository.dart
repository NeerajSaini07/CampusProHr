import 'package:campus_pro/src/DATA/API_SERVICES/getCoordinatorProfileApi.dart';
import 'package:campus_pro/src/DATA/MODELS/getCoordinatorProfileModel.dart';

abstract class GetCoordinatorProfileRepositoryAbs {
  Future<List<GetCoordinatorProfileModel>> getProfile(
      Map<String, String?> request);
}

class GetCoordinatorProfileRepository
    extends GetCoordinatorProfileRepositoryAbs {
  final GetCoordinatorProfileApi _api;
  GetCoordinatorProfileRepository(this._api);

  Future<List<GetCoordinatorProfileModel>> getProfile(
      Map<String, String?> request) {
    var data = _api.getProfile(request);
    return data;
  }
}
