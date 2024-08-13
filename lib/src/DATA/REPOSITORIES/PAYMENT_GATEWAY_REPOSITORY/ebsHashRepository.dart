import 'package:campus_pro/src/DATA/API_SERVICES/PAYMENT_GATEWAY_API/EbsHashApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/classListApi.dart';
import 'package:campus_pro/src/DATA/MODELS/PAYMENT_GATEWAY_MODELS/ebsHashModel.dart';
import 'package:campus_pro/src/DATA/MODELS/PAYMENT_GATEWAY_MODELS/payUBizzHashModel.dart';
import 'package:campus_pro/src/DATA/MODELS/classListModel.dart';

abstract class EbsHashRepositoryAbs {
  Future<List<EbsHashModel>> ebsHash(Map<String, String> sendData);
}

class EbsHashRepository extends EbsHashRepositoryAbs {
  final EbsHashApi _api;
  EbsHashRepository(this._api);

  Future<List<EbsHashModel>> ebsHash(Map<String, String?> sendData) async {
    final data = await _api.ebsHash(sendData);
    return data;
  }
}
