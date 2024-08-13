import 'package:campus_pro/src/DATA/API_SERVICES/classListEmployeeApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/feeBalanceClassListEmployeeApi.dart';
import 'package:campus_pro/src/DATA/MODELS/classListEmployeeModel.dart';
import 'package:campus_pro/src/DATA/MODELS/feeBalanceClassListEmployeeModel.dart';

abstract class FeeBalanceClassListEmployeeRepositoryAbs {
  Future<List<FeeBalanceClassListEmployeeModel>> getClass(
      Map<String, String?> requestPayload);
}

class FeeBalanceClassListEmployeeRepository
    extends FeeBalanceClassListEmployeeRepositoryAbs {
  final FeeBalanceClassListEmployeeApi _api;
  FeeBalanceClassListEmployeeRepository(this._api);

  Future<List<FeeBalanceClassListEmployeeModel>> getClass(
      Map<String, String?> requestPayload) async {
    final data = await _api.getClass(requestPayload);
    return data;
  }
}
