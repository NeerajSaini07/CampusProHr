import 'package:campus_pro/src/DATA/API_SERVICES/log_in_api.dart';

abstract class LogInRepositoryAbs {
  Future<bool> logIn(Map<String, String> loginData);
}

class LogInRepository extends LogInRepositoryAbs {
  final LogInApi _api;

  LogInRepository(this._api);
  @override
  Future<bool> logIn(Map<String, String> loginData) async {
    final data = await _api.logIn(loginData);
    // await UserUtils.cacheData(data);
    return data;
  }
}
