import 'package:campus_pro/src/DATA/API_SERVICES/changePasswordStudentApi.dart';

abstract class ChangePasswordStudentRepositoryAbs {
  Future<String> changePassword(Map<String, String> requestPayload);
}

class ChangePasswordStudentRepository
    extends ChangePasswordStudentRepositoryAbs {
  final ChangePasswordStudentApi _api;
  ChangePasswordStudentRepository(this._api);

  Future<String> changePassword(Map<String, String?> requestPayload) async {
    final data = await _api.changePassword(requestPayload);
    return data;
  }
}
