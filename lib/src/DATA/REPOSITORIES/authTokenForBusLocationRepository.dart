import 'package:campus_pro/src/DATA/API_SERVICES/authTokenForBusLocationApi.dart';

abstract class AuthTokenForBusLocationRepositoryAbs {
  Future<String> authToken(Map<String, String> tokenData);
}

class AuthTokenForBusLocationRepository
    extends AuthTokenForBusLocationRepositoryAbs {
  final AuthTokenForBusLocationApi _api;
  AuthTokenForBusLocationRepository(this._api);
  @override
  Future<String> authToken(Map<String, String?> tokenData) async {
    final data = await _api.authToken(tokenData);
    return data;
  }
}
