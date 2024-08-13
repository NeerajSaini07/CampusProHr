import 'package:campus_pro/src/DATA/API_SERVICES/PAYMENT_GATEWAY_API/payUBizHashApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/classListApi.dart';
import 'package:campus_pro/src/DATA/MODELS/PAYMENT_GATEWAY_MODELS/payUBizzHashModel.dart';
import 'package:campus_pro/src/DATA/MODELS/classListModel.dart';

abstract class PayUBizHashRepositoryAbs {
  Future<List<PayUBizHashModel>> payUBizHash(Map<String, String> sendData);
}

class PayUBizHashRepository extends PayUBizHashRepositoryAbs {
  final PayUBizHashApi _api;
  PayUBizHashRepository(this._api);

  Future<List<PayUBizHashModel>> payUBizHash(
      Map<String, String?> sendData) async {
    final data = await _api.payUBizHash(sendData);
    return data;
  }
}
