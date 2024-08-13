import 'package:campus_pro/src/DATA/API_SERVICES/feeHeadBalanceFeeApi.dart';
import 'package:campus_pro/src/DATA/MODELS/feeHeadBalanceFeeModel.dart';

abstract class FeeHeadBalanceFeeRepositoryAbs {
  Future<List<FeeHeadBalanceFeeModel>> feeHeadBalanceFeeData(
      Map<String, String?> requestPayload);
}

class FeeHeadBalanceFeeRepository extends FeeHeadBalanceFeeRepositoryAbs {
  final FeeHeadBalanceFeeApi _api;
  FeeHeadBalanceFeeRepository(this._api);

  Future<List<FeeHeadBalanceFeeModel>> feeHeadBalanceFeeData(
      Map<String, String?> requestPayload) async {
    final data = await _api.feeHeadBalanceFeeData(requestPayload);
    return data;
  }
}
