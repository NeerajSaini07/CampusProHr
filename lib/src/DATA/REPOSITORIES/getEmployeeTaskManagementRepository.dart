import 'package:campus_pro/src/DATA/API_SERVICES/getEmployeeTaskManagementApi.dart';
import 'package:campus_pro/src/DATA/MODELS/getEmployeeTaskManagementModel.dart';

abstract class GetEmployeeTaskManagementRepositoryAbs {
  Future<List<GetEmployeeTaskManagementModel>> getEmployee(
      Map<String, String?> payload);
}

class GetEmployeeTaskManagementRepository
    extends GetEmployeeTaskManagementRepositoryAbs {
  final GetEmployeeTaskManagementApi _api;
  GetEmployeeTaskManagementRepository(this._api);

  Future<List<GetEmployeeTaskManagementModel>> getEmployee(
      Map<String, String?> payload) {
    var data = _api.getEmployee(payload);
    return data;
  }
}
