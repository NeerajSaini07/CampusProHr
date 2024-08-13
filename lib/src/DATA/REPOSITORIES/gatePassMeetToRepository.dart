import 'package:campus_pro/src/DATA/API_SERVICES/gatePassMeetToApi.dart';
import 'package:campus_pro/src/DATA/MODELS/gatePassMeetToModel.dart';

abstract class GatePassMeetToRepositoryAbs {
  Future<List<GatePassMeetToModel>> getData(
      Map<String, String?> payload, int? num);
}

class GatePassMeetToRepository extends GatePassMeetToRepositoryAbs {
  final GatePassMeetToApi _api;

  GatePassMeetToRepository(this._api);

  @override
  Future<List<GatePassMeetToModel>> getData(
      Map<String, String?> payload, int? num) {
    var data = _api.getData(payload, num);
    return data;
  }
}
