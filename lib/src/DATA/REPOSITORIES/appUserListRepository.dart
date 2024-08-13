import 'package:campus_pro/src/DATA/API_SERVICES/appUserListApi.dart';
import 'package:campus_pro/src/DATA/MODELS/appUserListModel.dart';

abstract class AppUserListRepositoryAbs {
  Future<List<AppUserListModel>> appUserList(
      Map<String, String> requestPayload, bool coordinator);
}

class AppUserListRepository extends AppUserListRepositoryAbs {
  final AppUserListApi _api;
  AppUserListRepository(this._api);

  Future<List<AppUserListModel>> appUserList(
      Map<String, String?> requestPayload, bool coordinator) async {
    final data = await _api.appUserList(requestPayload, coordinator);
    return data;
  }
}
