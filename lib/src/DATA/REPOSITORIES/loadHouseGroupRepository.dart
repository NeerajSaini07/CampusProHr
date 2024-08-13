import 'package:campus_pro/src/DATA/API_SERVICES/loadHouseGroupApi.dart';
import 'package:campus_pro/src/DATA/MODELS/loadHouseGroupModel.dart';

abstract class LoadHouseGroupRepositoryAbs {
  Future<List<LoadHouseGroupModel>> getHouses(Map<String, String?> request);
}

class LoadHouseGroupRepository extends LoadHouseGroupRepositoryAbs {
  final LoadHouseGroupApi _api;
  LoadHouseGroupRepository(this._api);

  Future<List<LoadHouseGroupModel>> getHouses(Map<String, String?> request) {
    final data = _api.getHouses(request);
    return data;
  }
}
