import 'package:campus_pro/src/DATA/API_SERVICES/header_token_api.dart';

abstract class HeaderTokenRepositoryAbs {
  Future<String> getHeaderToken(Map<String, String> body);
}

class HeaderTokenRepository extends HeaderTokenRepositoryAbs {
  final HeaderTokenApi _api;
  HeaderTokenRepository(this._api);

  @override
  Future<String> getHeaderToken(Map<String, String> body) async {
    final data = await _api.getHeaderToken(body);
    return data;
  }
}