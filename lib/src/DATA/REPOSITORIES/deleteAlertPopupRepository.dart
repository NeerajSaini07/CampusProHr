import 'package:campus_pro/src/DATA/API_SERVICES/deleteAlertPopupApi.dart';

abstract class DeleteAlertPopupRepositoryAbs {
  Future<String> deleteAlert(Map<String, String?> request);
}

class DeleteAlertPopupRepository extends DeleteAlertPopupRepositoryAbs {
  final DeleteAlertPopupApi _api;
  DeleteAlertPopupRepository(this._api);

  Future<String> deleteAlert(Map<String, String?> request) {
    var data = _api.deleteAlert(request);
    return data;
  }
}
