import 'package:campus_pro/src/DATA/API_SERVICES/billsListBillApproveApi.dart';
import 'package:campus_pro/src/DATA/MODELS/billsListBillApproveModel.dart';

abstract class BillsListBillApproveRepositoryAbs {
  Future<List<BillsListBillApproveModel>> billsListBillApproveData(
      Map<String, String?> requestPayload);
}

class BillsListBillApproveRepository extends BillsListBillApproveRepositoryAbs {
  final BillsListBillApproveApi _api;
  BillsListBillApproveRepository(this._api);

  Future<List<BillsListBillApproveModel>> billsListBillApproveData(
      Map<String, String?> requestPayload) async {
    final data = await _api.billsListBillApproveData(requestPayload);
    return data;
  }
}
