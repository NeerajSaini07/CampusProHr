import 'package:campus_pro/src/DATA/API_SERVICES/checkEmailRegistrationApi.dart';
import 'package:campus_pro/src/DATA/MODELS/checkEmailRegistrationModel.dart';

abstract class CheckEmailRegistrationRepositoryAbs {
  Future<CheckEmailRegistrationModel> checkEmailRegistration(
      Map<String, String> emailData);
}

class CheckEmailRegistrationRepository
    extends CheckEmailRegistrationRepositoryAbs {
  final CheckEmailRegistrationApi _api;
  CheckEmailRegistrationRepository(this._api);

  Future<CheckEmailRegistrationModel> checkEmailRegistration(
      Map<String, String?> emailData) async {
    final data = await _api.checkEmailRegistration(emailData);
    return data;
  }
}
