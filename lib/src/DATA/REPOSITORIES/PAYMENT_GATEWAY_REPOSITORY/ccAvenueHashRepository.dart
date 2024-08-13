import 'package:campus_pro/src/DATA/API_SERVICES/PAYMENT_GATEWAY_API/CCAvenueHashApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/classListApi.dart';
import 'package:campus_pro/src/DATA/MODELS/PAYMENT_GATEWAY_MODELS/ccAvenueHashModel.dart';
import 'package:campus_pro/src/DATA/MODELS/PAYMENT_GATEWAY_MODELS/payUBizzHashModel.dart';
import 'package:campus_pro/src/DATA/MODELS/classListModel.dart';

abstract class CCAvenueHashRepositoryAbs {
  Future<List<CCAvenueHashModel>> ccAvenueHash(Map<String, String> sendData);
}

class CCAvenueHashRepository extends CCAvenueHashRepositoryAbs {
  final CCAvenueHashApi _api;
  CCAvenueHashRepository(this._api);

  Future<List<CCAvenueHashModel>> ccAvenueHash(
      Map<String, String?> sendData) async {
    final data = await _api.ccAvenueHash(sendData);
    return data;
  }
}
