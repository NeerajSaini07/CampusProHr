import 'package:campus_pro/src/DATA/API_SERVICES/savePopupAlertApi.dart';

abstract class SavePopupAlertRepositoryAbs {
  Future<String> savePopupAlert(Map<String, String?> request);
}

class SavePopupAlertRepository extends SavePopupAlertRepositoryAbs {
  final SavePopupAlertApi _api;

  SavePopupAlertRepository(this._api);

  Future<String> savePopupAlert(Map<String, String?> request) {
    var data = _api.saveAlertPopup(request);
    return data;
  }
}
