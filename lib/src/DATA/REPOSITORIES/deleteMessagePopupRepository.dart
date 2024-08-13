import 'package:campus_pro/src/DATA/API_SERVICES/deleteMessagePopupApi.dart';

abstract class DeleteMessagePopupRepositoryAbs {
  Future<String> deleteMessage(Map<String, String?> request);
}

class DeleteMessagePopupRepository extends DeleteMessagePopupRepositoryAbs {
  final DeleteMessagePopupApi _api;
  DeleteMessagePopupRepository(this._api);

  Future<String> deleteMessage(Map<String, String?> request) {
    var data = _api.deleteMessage(request);
    return data;
  }
}
