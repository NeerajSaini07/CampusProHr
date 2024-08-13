import 'package:campus_pro/src/DATA/API_SERVICES/PAYMENT_GATEWAY_API/gatewayTypeApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/classListApi.dart';
import 'package:campus_pro/src/DATA/MODELS/PAYMENT_GATEWAY_MODELS/gatewayTypeModel.dart';
import 'package:campus_pro/src/DATA/MODELS/classListModel.dart';

abstract class GatewayTypeRepositoryAbs {
  Future<String> gatewayType(Map<String, String> gatewayData);
}

class GatewayTypeRepository extends GatewayTypeRepositoryAbs {
  final GatewayTypeApi _api;
  GatewayTypeRepository(this._api);

  Future<String> gatewayType(
      Map<String, String?> gatewayData) async {
    final data = await _api.gatewayType(gatewayData);
    return data;
  }
}
