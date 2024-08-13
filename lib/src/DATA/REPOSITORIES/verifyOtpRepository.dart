import 'package:campus_pro/src/DATA/API_SERVICES/verifyOtpApi.dart';

abstract class VerifyOtpRepositoryAbs {
  Future<bool> verifyOtp(Map<String, String> otpData);
}

class VerifyOtpRepository extends VerifyOtpRepositoryAbs {
  final VerifyOtpApi _api;
  VerifyOtpRepository(this._api);

  Future<bool> verifyOtp(Map<String, String?> otpData) async {
    final data = await _api.verifyOtp(otpData);
    return data;
  }
}
