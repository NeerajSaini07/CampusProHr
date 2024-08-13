import 'package:campus_pro/src/DATA/API_SERVICES/partyTypeBillApproveApi.dart';
import 'package:campus_pro/src/DATA/MODELS/partyTypeBillApproveModel.dart';

abstract class PartyTypeBillApproveRepositoryAbs {
  Future<List<PartyTypeBillApproveModel>> partyTypeBillApproveData(
      Map<String, String?> requestPayload);
}

class PartyTypeBillApproveRepository extends PartyTypeBillApproveRepositoryAbs {
  final PartyTypeBillApproveApi _api;
  PartyTypeBillApproveRepository(this._api);

  Future<List<PartyTypeBillApproveModel>> partyTypeBillApproveData(
      Map<String, String?> requestPayload) async {
    final data = await _api.partyTypeBillApproveData(requestPayload);
    return data;
  }
}
