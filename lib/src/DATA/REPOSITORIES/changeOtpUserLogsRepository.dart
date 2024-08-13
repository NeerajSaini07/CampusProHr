import 'package:campus_pro/src/DATA/API_SERVICES/changeOtpUserLogsApi.dart';

abstract class ChangeOtpUserLogsRepositoryAbs {
  Future<bool> changeOtpUserLogs(Map<String, String> requestPayload);
}

class ChangeOtpUserLogsRepository extends ChangeOtpUserLogsRepositoryAbs {
  final ChangeOtpUserLogsApi _api;
  ChangeOtpUserLogsRepository(this._api);

  Future<bool> changeOtpUserLogs(Map<String, String?> requestPayload) async {
    final data = await _api.changeOtpUserLogs(requestPayload);
    return data;
  }
}
