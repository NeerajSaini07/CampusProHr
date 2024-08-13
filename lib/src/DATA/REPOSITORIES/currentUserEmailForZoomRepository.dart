import 'package:campus_pro/src/DATA/API_SERVICES/currentUserEmailForZoomApi.dart';
import 'package:campus_pro/src/DATA/MODELS/currentUserEmailForZoomModel.dart';

abstract class CurrentUserEmailForZoomRepositoryAbs {
  Future<List<CurrentUserEmailForZoomModel>> emailId(
      Map<String, String> emailData);
}

class CurrentUserEmailForZoomRepository extends CurrentUserEmailForZoomRepositoryAbs {
  final CurrentUserEmailForZoomApi _api;
  CurrentUserEmailForZoomRepository(this._api);
  @override
  Future<List<CurrentUserEmailForZoomModel>> emailId(
      Map<String, String?> emailData) async {
    final data = await _api.emailId(emailData);
    return data;
  }
}
