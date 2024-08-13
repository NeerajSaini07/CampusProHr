import 'package:campus_pro/src/DATA/API_SERVICES/billDetailsBillApproveApi.dart';
import 'package:campus_pro/src/DATA/MODELS/billDetailsBillApproveModel.dart';

abstract class BillDetailsBillApproveRepositoryAbs {
  Future<BillDetailsBillApproveModel> billDetailsBillApproveData(
      Map<String, String?> requestPayload);
}

class BillDetailsBillApproveRepository
    extends BillDetailsBillApproveRepositoryAbs {
  final BillDetailsBillApproveApi _api;
  BillDetailsBillApproveRepository(this._api);

  Future<BillDetailsBillApproveModel> billDetailsBillApproveData(
      Map<String, String?> requestPayload) async {
    final data = await _api.billDetailsBillApproveData(requestPayload);
    return data;
  }
}
