import 'package:campus_pro/src/DATA/API_SERVICES/employeeStatusListApi.dart';
import 'package:campus_pro/src/DATA/MODELS/employeeStatusListModel.dart';

abstract class EmployeeStatusListRespositoryAbs {
  Future<EmployeeStatusListModel> employeeStatus(Map<String, String?> statusData);
}

class EmployeeStatusListRepository extends EmployeeStatusListRespositoryAbs {
  final EmployeeStatusListApi _api;

  EmployeeStatusListRepository(this._api);
  @override
  Future<EmployeeStatusListModel> employeeStatus(
      Map<String, String?> statusData) async {
    final data = await _api.employeeStatus(statusData);
    return data;
  }
}
