import 'package:campus_pro/src/DATA/API_SERVICES/PAYMENT_GATEWAY_API/payUMoneyHashApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/classListApi.dart';
import 'package:campus_pro/src/DATA/MODELS/PAYMENT_GATEWAY_MODELS/payUMoneyHashModel.dart';
import 'package:campus_pro/src/DATA/MODELS/classListModel.dart';

abstract class PayUMoneyHashRepositoryAbs {
  Future<List<PayUMoneyHashModel>> payUMoneyHash(Map<String, String> sendData);
}

class PayUMoneyHashRepository extends PayUMoneyHashRepositoryAbs {
  final PayUMoneyHashApi _api;
  PayUMoneyHashRepository(this._api);

  Future<List<PayUMoneyHashModel>> payUMoneyHash(
      Map<String, String?> sendData) async {
    final data = await _api.payUMoneyHash(sendData);
    return data;
  }
}
