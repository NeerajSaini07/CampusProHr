import 'package:campus_pro/src/DATA/API_SERVICES/getPopupAlertListApi.dart';
import 'package:campus_pro/src/DATA/MODELS/getPopupAlertListModel.dart';

abstract class GetPopupAlertListRepositoryAbs {
  Future<List<GetPopupAlertListModel>> getPopupAlertList(
      Map<String, String?> request);
}

class GetPopupAlertListRepository extends GetPopupAlertListRepositoryAbs {
  final GetPopupAlertListApi _api;

  GetPopupAlertListRepository(this._api);

  Future<List<GetPopupAlertListModel>> getPopupAlertList(
      Map<String, String?> request) {
    var data = _api.getPopupList(request);
    return data;
  }
}
