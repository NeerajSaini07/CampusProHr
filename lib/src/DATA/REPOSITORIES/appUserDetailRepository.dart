import 'package:campus_pro/src/DATA/API_SERVICES/appUserDetailApi.dart';
import 'package:campus_pro/src/DATA/MODELS/appUserDetailModel.dart';

abstract class AppUserDetailRepositoryAbs {
  Future<List<AppUserDetailModel>> appUserDetail(
      Map<String, String> requestPayload);
}

class AppUserDetailRepository extends AppUserDetailRepositoryAbs {
  final AppUserDetailApi _api;
  AppUserDetailRepository(this._api);

  Future<List<AppUserDetailModel>> appUserDetail(
      Map<String, String?> requestPayload) async {
    final data = await _api.appUserDetail(requestPayload);
    return data;
  }
}
