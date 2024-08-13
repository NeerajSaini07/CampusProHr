import 'package:campus_pro/src/DATA/API_SERVICES/setPlateformApi.dart';

abstract class SetPlateformRepositoryAbs {
  Future<dynamic> getPlatform(Map<String, String?> request);
}

class SetPlateformRepository extends SetPlateformRepositoryAbs {
  final SetPlateformApi _api;

  SetPlateformRepository(this._api);

  Future<dynamic> getPlatform(Map<String, String?> request) {
    var data = _api.getPlatform(request);
    return data;
  }
}
