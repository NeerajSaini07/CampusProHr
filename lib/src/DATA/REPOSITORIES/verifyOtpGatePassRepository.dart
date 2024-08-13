import 'package:campus_pro/src/DATA/API_SERVICES/verifyOtpGatePassApi.dart';

abstract class VerifyOtpGatePassRepositoryAbs {
  Future<String> verifyOtp(Map<String, String?> payload);
}

class VerifyOtpGatePassRepository extends VerifyOtpGatePassRepositoryAbs {
  final VerifyOtpGatePassApi _api;
  VerifyOtpGatePassRepository(this._api);

  Future<String> verifyOtp(Map<String, String?> payload) {
    var data = _api.verifyOtp(payload);
    return data;
  }
}
