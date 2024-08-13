import 'package:campus_pro/src/DATA/API_SERVICES/otpUserListApi.dart';
import 'package:campus_pro/src/DATA/MODELS/otpUserListModel.dart';

abstract class OtpUserListRepositoryAbs {
  Future<List<OtpUserListModel>> otpUserList(
      Map<String, String> requestPayload, bool status);
}

class OtpUserListRepository extends OtpUserListRepositoryAbs {
  final OtpUserListApi _api;
  OtpUserListRepository(this._api);

  Future<List<OtpUserListModel>> otpUserList(
      Map<String, String?> requestPayload, bool status) async {
    final data = await _api.otpUserList(requestPayload, status);
    return data;
  }
}
