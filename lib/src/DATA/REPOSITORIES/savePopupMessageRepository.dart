import 'package:campus_pro/src/DATA/API_SERVICES/savePopupMessageApi.dart';

abstract class SavePopupMessageRepositoryAbs {
  Future<String> savePopupMessage(Map<String, String?> request);
}

class SavePopupMessageRepository extends SavePopupMessageRepositoryAbs {
  final SavePopupMessageApi _api;

  SavePopupMessageRepository(this._api);

  Future<String> savePopupMessage(Map<String, String?> request) {
    var data = _api.saveMessagePopup(request);
    return data;
  }
}
