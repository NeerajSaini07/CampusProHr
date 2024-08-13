import 'package:campus_pro/src/DATA/API_SERVICES/loadAddressGroupApi.dart';
import 'package:campus_pro/src/DATA/MODELS/loadAddressGroupModel.dart';

abstract class LoadAddressGroupRepositoryAbs {
  Future<List<LoadAddressGroupModel>> getAddress(Map<String, String?> request);
}

class LoadAddressGroupRepository extends LoadAddressGroupRepositoryAbs {
  final LoadAddressGroupApi _api;
  LoadAddressGroupRepository(this._api);

  Future<List<LoadAddressGroupModel>> getAddress(Map<String, String?> request) {
    final data = _api.getAddress(request);
    return data;
  }
}
