import 'package:campus_pro/src/DATA/API_SERVICES/getGatePassHistoryApi.dart';
import 'package:campus_pro/src/DATA/MODELS/getGatePassHistoryModal.dart';

abstract class GetGatePassHistoryRepositoryAbs {
  Future<List<GetGatePassHistoryModal>> getGatePassHistory(
      Map<String, String?> request);
}

class GetGatePassHistoryRepository extends GetGatePassHistoryRepositoryAbs {
  final GetGatePassHistoryApi _api;
  GetGatePassHistoryRepository(this._api);

  Future<List<GetGatePassHistoryModal>> getGatePassHistory(
      Map<String, String?> request) {
    var data = _api.getGatePassHistory(request);
    return data;
  }
}
