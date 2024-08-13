import 'package:campus_pro/src/DATA/API_SERVICES/inactiveCompOrSuggApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/replyComplainSuggestionAdminApi.dart';

abstract class InactiveCompOrSuggRepositoryAbs {
  Future<String> inActiveSuggestion(Map<String, String?> inActiveSug);
}

class InactiveCompOrSuggRepository extends InactiveCompOrSuggRepositoryAbs {
  final InactiveCompOrSuggApi _api;
  InactiveCompOrSuggRepository(this._api);

  Future<String> inActiveSuggestion(Map<String, String?> inActiveSug) async {
    final data = await _api.inActiveSug(inActiveSug);
    return data;
  }
}
