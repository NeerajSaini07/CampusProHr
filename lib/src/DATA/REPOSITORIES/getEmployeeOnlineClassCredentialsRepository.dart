import 'package:campus_pro/src/DATA/API_SERVICES/getEmployeeOnlineClassCredentialsApi.dart';

abstract class GetEmployeeOnlineClassCredentialsRepositoryAbs {
  Future<dynamic> getValues(Map<String, String?> request, String mode);
}

class GetEmployeeOnlineClassCredentialsRepository
    extends GetEmployeeOnlineClassCredentialsRepositoryAbs {
  final GetEmployeeOnlineClassCredentialsApi _api;
  GetEmployeeOnlineClassCredentialsRepository(this._api);

  Future<dynamic> getValues(Map<String, String?> request, String mode) {
    var data = _api.getValues(request, mode);
    return data;
  }
}
