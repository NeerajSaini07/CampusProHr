import 'package:campus_pro/src/DATA/API_SERVICES/feeBalanceMonthListEmployeeApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/classListEmployeeApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/feeBalanceClassListEmployeeApi.dart';
import 'package:campus_pro/src/DATA/MODELS/classListEmployeeModel.dart';
import 'package:campus_pro/src/DATA/MODELS/feeBalanceClassListEmployeeModel.dart';
import 'package:campus_pro/src/DATA/MODELS/feeBalanceMonthListEmployeeModel.dart';

abstract class FeeBalanceMonthListEmployeeRepositoryAbs {
  Future<List<FeeBalanceMonthListEmployeeModel>> getMonth(
      Map<String, String?> requestPayload);
}

class FeeBalanceMonthListEmployeeRepository
    extends FeeBalanceMonthListEmployeeRepositoryAbs {
  final FeeBalanceMonthListEmployeeApi _api;
  FeeBalanceMonthListEmployeeRepository(this._api);

  Future<List<FeeBalanceMonthListEmployeeModel>> getMonth(
      Map<String, String?> requestPayload) async {
    final data = await _api.getMonth(requestPayload);
    return data;
  }
}
