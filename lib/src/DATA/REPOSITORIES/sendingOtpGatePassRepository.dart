import 'package:campus_pro/src/DATA/API_SERVICES/sendingOtpGatePassApi.dart';

abstract class SendingOtpGatePassRepositoryAbs {
  Future<String?> getData(Map<String, String?> data);
}

class SendingOtpGatePassRepository extends SendingOtpGatePassRepositoryAbs {
  final SendingOtpGatePassApi _api;
  SendingOtpGatePassRepository(this._api);

  @override
  Future<String?> getData(Map<String, String?> data) {
    var result = _api.getData(data);
    return result;
  }
}
