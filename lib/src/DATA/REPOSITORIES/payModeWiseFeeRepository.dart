import 'package:campus_pro/src/DATA/API_SERVICES/payModeWiseFeeApi.dart';
import 'package:campus_pro/src/DATA/MODELS/payModeWiseFeeModel.dart';

abstract class PayModeWiseFeeRepositoryAbs {
  Future<PayModeWiseFeeModel> payModeWiseFeeData(
      Map<String, String?> requestPayload);
}

class PayModeWiseFeeRepository extends PayModeWiseFeeRepositoryAbs {
  final PayModeWiseFeeApi _api;
  PayModeWiseFeeRepository(this._api);

  Future<PayModeWiseFeeModel> payModeWiseFeeData(
      Map<String, String?> requestPayload) async {
    final data = await _api.payModeWiseFeeData(requestPayload);
    return data;
  }
}
