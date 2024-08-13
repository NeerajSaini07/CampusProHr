import 'dart:io';

import 'package:campus_pro/src/DATA/API_SERVICES/verifyIdProofGatePassApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/verifyOtpGatePassApi.dart';

abstract class VerifyIdProofGatePassRepositoryAbs {
  Future<String> verifyId(Map<String, String> payload, File? img);
}

class VerifyIdProofGatePassRepository
    extends VerifyIdProofGatePassRepositoryAbs {
  final VerifyIdProofGatePassApi _api;
  VerifyIdProofGatePassRepository(this._api);

  Future<String> verifyId(Map<String, String> payload, File? img) {
    var data = _api.verifyId(payload, img);
    return data;
  }
}
