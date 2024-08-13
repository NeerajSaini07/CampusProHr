import 'package:campus_pro/src/DATA/API_SERVICES/fcmTokenStoreApi.dart';

abstract class FcmTokenStoreRepositoryAbs {
  Future<bool> saveToken();
}

class FcmTokenStoreRepository extends FcmTokenStoreRepositoryAbs {
  final FcmTokenStoreApi _api;
  FcmTokenStoreRepository(this._api);
  @override
  Future<bool> saveToken() async {
    final data = await _api.storeToken();
    return data;
  }
}
