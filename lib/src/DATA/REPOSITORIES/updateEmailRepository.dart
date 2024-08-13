import 'package:campus_pro/src/DATA/API_SERVICES/updateEmailApi.dart';

abstract class UpdateEmailRepositoryAbs {
  Future<bool> updateEmail(Map<String, String> emailData);
}

class UpdateEmailRepository extends UpdateEmailRepositoryAbs {
  final UpdateEmailApi _api;
  UpdateEmailRepository(this._api);

  Future<bool> updateEmail(Map<String, String?> emailData) async {
    final data = await _api.updateEmail(emailData);
    return data;
  }
}
