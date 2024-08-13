import 'package:campus_pro/src/DATA/API_SERVICES/VisitorListTodayGatePassApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/markVisitorExitApi.dart';
import 'package:campus_pro/src/DATA/MODELS/visitorListTodayModel.dart';

abstract class MarkVisitorExitRepositoryAbs {
  Future<String> markExit(Map<String, String?> payload, int num);
}

class MarkVisitorExitRepository extends MarkVisitorExitRepositoryAbs {
  final MarkVisitorExitApi _api;
  MarkVisitorExitRepository(this._api);
  @override
  Future<String> markExit(Map<String, String?> payload, int num) async {
    final data = await _api.markExit(payload, num);
    return data;
  }
}
