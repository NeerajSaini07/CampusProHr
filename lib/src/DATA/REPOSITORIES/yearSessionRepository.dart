import 'package:campus_pro/src/DATA/API_SERVICES/yearSessionApi.dart';
import 'package:campus_pro/src/DATA/MODELS/yearSessionModel.dart';

abstract class YearSessionRepositoryAbs {
  Future<List<YearSessionModel>> yearSessionData(
      Map<String, String> requestPayload);
}

class YearSessionRepository extends YearSessionRepositoryAbs {
  final YearSessionApi _api;
  YearSessionRepository(this._api);

  Future<List<YearSessionModel>> yearSessionData(
      Map<String, String?> requestPayload) async {
    final data = await _api.yearSessionData(requestPayload);
    return data;
  }
}
