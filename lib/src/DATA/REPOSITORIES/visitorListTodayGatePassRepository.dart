import 'package:campus_pro/src/DATA/API_SERVICES/VisitorListTodayGatePassApi.dart';
import 'package:campus_pro/src/DATA/MODELS/visitorListTodayModel.dart';

abstract class VisitorListTodayGatePassRepositoryAbs {
  Future<List<VisitorListTodayGatePassModel>> getList(
      Map<String, String?> payload);
}

class VisitorListTodayGatePassRepository
    extends VisitorListTodayGatePassRepositoryAbs {
  final VisitorListTodayGatePassApi _api;
  VisitorListTodayGatePassRepository(this._api);
  @override
  Future<List<VisitorListTodayGatePassModel>> getList(
      Map<String, String?> payload) async {
    final data = await _api.getList(payload);
    return data;
  }
}
