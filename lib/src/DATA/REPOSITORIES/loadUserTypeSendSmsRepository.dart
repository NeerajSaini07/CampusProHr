import 'package:campus_pro/src/DATA/API_SERVICES/loadUserTypeSendSmsApi.dart';
import 'package:campus_pro/src/DATA/MODELS/loadUserTypeSendSmsModel.dart';

abstract class LoadUserTypeSendSmsRepositoryAbs {
  Future<List<LoadUserTypeSendSmsModel>> getUserType(
      Map<String, String?> request);
}

class LoadUserTypeSendSmsRepository extends LoadUserTypeSendSmsRepositoryAbs {
  final LoadUserTypeSendSmsApi _api;
  LoadUserTypeSendSmsRepository(this._api);

  Future<List<LoadUserTypeSendSmsModel>> getUserType(
      Map<String, String?> request) {
    var data = _api.getUserType(request);
    return data;
  }
}
