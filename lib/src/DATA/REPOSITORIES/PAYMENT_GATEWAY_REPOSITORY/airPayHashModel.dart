import 'package:campus_pro/src/DATA/API_SERVICES/PAYMENT_GATEWAY_API/AirPayHashApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/classListApi.dart';
import 'package:campus_pro/src/DATA/MODELS/PAYMENT_GATEWAY_MODELS/airPayHashModel.dart';
import 'package:campus_pro/src/DATA/MODELS/PAYMENT_GATEWAY_MODELS/payUBizzHashModel.dart';
import 'package:campus_pro/src/DATA/MODELS/classListModel.dart';

abstract class AirPayHashRepositoryAbs {
  Future<List<AirPayHashModel>> airPayHash(Map<String, String> sendData);
}

class AirPayHashRepository extends AirPayHashRepositoryAbs {
  final AirPayHashApi _api;
  AirPayHashRepository(this._api);

  Future<List<AirPayHashModel>> airPayHash(
      Map<String, String?> sendData) async {
    final data = await _api.airPayHash(sendData);
    return data;
  }
}
