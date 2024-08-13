import 'package:campus_pro/src/DATA/API_SERVICES/PAYMENT_GATEWAY_API/TechProcessHashApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/classListApi.dart';
import 'package:campus_pro/src/DATA/MODELS/PAYMENT_GATEWAY_MODELS/payUBizzHashModel.dart';
import 'package:campus_pro/src/DATA/MODELS/PAYMENT_GATEWAY_MODELS/techProcessHashModel.dart';
import 'package:campus_pro/src/DATA/MODELS/classListModel.dart';

abstract class TechProcessHashRepositoryAbs {
  Future<List<TechProcessHashModel>> techProcessHash(
      Map<String, String> sendData);
}

class TechProcessHashRepository extends TechProcessHashRepositoryAbs {
  final TechProcessHashApi _api;
  TechProcessHashRepository(this._api);

  Future<List<TechProcessHashModel>> techProcessHash(
      Map<String, String?> sendData) async {
    final data = await _api.techProcessHash(sendData);
    return data;
  }
}
