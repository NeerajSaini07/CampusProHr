import 'package:campus_pro/src/DATA/API_SERVICES/forgotPasswordApi.dart';

abstract class ForgotPasswordRepositoryAbs {
  Future<bool> forgotPassword(Map<String, String> mobileNo);
}

class ForgotPasswordRepository extends ForgotPasswordRepositoryAbs {
  final ForgotPasswordApi _api;
  ForgotPasswordRepository(this._api);

  Future<bool> forgotPassword(Map<String, String?> mobileNo) async {
    final data = await _api.forgotPassword(mobileNo);
    return data;
  }
}
