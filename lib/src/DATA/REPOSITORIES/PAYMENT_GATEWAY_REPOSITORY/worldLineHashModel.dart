import 'package:campus_pro/src/DATA/API_SERVICES/PAYMENT_GATEWAY_API/WorldLineHashApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/classListApi.dart';
import 'package:campus_pro/src/DATA/MODELS/PAYMENT_GATEWAY_MODELS/payUBizzHashModel.dart';
import 'package:campus_pro/src/DATA/MODELS/PAYMENT_GATEWAY_MODELS/worldLineHashModel.dart';
import 'package:campus_pro/src/DATA/MODELS/classListModel.dart';

abstract class WorldLineHashRepositoryAbs {
  Future<List<WorldLineHashModel>> worldLineHash(Map<String, String> sendData);
}

class WorldLineHashRepository extends WorldLineHashRepositoryAbs {
  final WorldLineHashApi _api;
  WorldLineHashRepository(this._api);

  Future<List<WorldLineHashModel>> worldLineHash(
      Map<String, String?> sendData) async {
    final data = await _api.worldLineHash(sendData);
    return data;
  }
}
