import 'package:campus_pro/src/DATA/API_SERVICES/loadEmployeeGroupsApi.dart';
import 'package:campus_pro/src/DATA/MODELS/loadEmployeeGroupsModel.dart';

abstract class LoadEmployeeGroupsRepositoryAbs {
  Future<List<LoadEmployeeGroupsModel>> getEmployee(
      Map<String, String?> request);
}

class LoadEmployeeGroupsRepository extends LoadEmployeeGroupsRepositoryAbs {
  final LoadEmployeeGroupsApi _api;
  LoadEmployeeGroupsRepository(this._api);

  Future<List<LoadEmployeeGroupsModel>> getEmployee(
      Map<String, String?> request) {
    final data = _api.getEmployee(request);
    return data;
  }
}
