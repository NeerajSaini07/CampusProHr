import 'package:campus_pro/src/DATA/API_SERVICES/emailCheckScheduleMeetingApi.dart';

abstract class EmailCheckScheduleMeetingRepositoryAbs {
  Future<String> emailCheck(Map<String, String> emailData);
}

class EmailCheckScheduleMeetingRepository
    extends EmailCheckScheduleMeetingRepositoryAbs {
  final EmailCheckScheduleMeetingApi _api;
  EmailCheckScheduleMeetingRepository(this._api);
  @override
  Future<String> emailCheck(Map<String, String?> emailData) async {
    final data = await _api.emailData(emailData);
    return data;
  }
}
