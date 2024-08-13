import 'package:campus_pro/src/DATA/API_SERVICES/remarkForStudentsListApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/replyComplainSuggestionAdminApi.dart';
import 'package:campus_pro/src/DATA/MODELS/remarkForStudentListModel.dart';

abstract class ReplyComplainSuggestionAdminRepositoryAbs {
  Future<String> replySuggestion(Map<String, String?> remarkData);
}

class ReplyComplainSuggestionAdminRepository
    extends ReplyComplainSuggestionAdminRepositoryAbs {
  final ReplyComplainSuggestionAdminApi _api;
  ReplyComplainSuggestionAdminRepository(this._api);

  Future<String> replySuggestion(Map<String, String?> remarkData) async {
    final data = await _api.replySuggestion(remarkData);
    return data;
  }
}
