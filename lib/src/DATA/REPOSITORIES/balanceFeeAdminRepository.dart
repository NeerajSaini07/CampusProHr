import 'package:campus_pro/src/DATA/API_SERVICES/balanceFeeAdminApi.dart';
import 'package:campus_pro/src/DATA/MODELS/balanceFeeAdminModel.dart';

abstract class BalanceFeeAdminRepositoryAbs {
  Future<List<BalanceFeeAdminModel>> balanceFeeAdminData(
      Map<String, String?> requestPayload);
}

class BalanceFeeAdminRepository extends BalanceFeeAdminRepositoryAbs {
  final BalanceFeeAdminApi _api;
  BalanceFeeAdminRepository(this._api);

  Future<List<BalanceFeeAdminModel>> balanceFeeAdminData(
      Map<String, String?> requestPayload) async {
    final data = await _api.balanceFeeAdminData(requestPayload);
    return data;
  }
}
