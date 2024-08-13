import 'package:campus_pro/src/DATA/API_SERVICES/activityApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/feeBalanceEmployeeApi.dart';
import 'package:campus_pro/src/DATA/MODELS/activityModel.dart';
import 'package:campus_pro/src/DATA/MODELS/feeBalanceEmployeeModel.dart';

abstract class FeeBalanceEmployeeRepositoryAbs {
  Future<List<FeeBalanceEmployeeModel>> feeBalanceData(
      Map<String, String> requestPayload);
}

class FeeBalanceEmployeeRepository extends FeeBalanceEmployeeRepositoryAbs {
  final FeeBalanceEmployeeApi _api;
  FeeBalanceEmployeeRepository(this._api);
  @override
  Future<List<FeeBalanceEmployeeModel>> feeBalanceData(
      Map<String, String?> requestPayload) async {
    final data = await _api.feeBalance(requestPayload);
    return data;
  }
}
