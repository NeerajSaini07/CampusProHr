import 'package:campus_pro/src/DATA/API_SERVICES/employeeInfoForSearchApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/studentInfoForSearchApi.dart';
import 'package:campus_pro/src/DATA/MODELS/employeeInfoForSearchModel.dart';
import 'package:campus_pro/src/DATA/MODELS/studentInfoForSearchModel.dart';

abstract class EmployeeInfoForSearchRepositoryAbs {
  Future<EmployeeInfoForSearchModel> getEmployeeInfoForSearch(
      Map<String, String> employeeData);
}

class EmployeeInfoForSearchRepository
    extends EmployeeInfoForSearchRepositoryAbs {
  final EmployeeInfoForSearchApi _api;
  EmployeeInfoForSearchRepository(this._api);

  @override
  Future<EmployeeInfoForSearchModel> getEmployeeInfoForSearch(
      Map<String, String> employeeData) async {
    final data = await _api.getEmployeeInfoForSearch(employeeData);
    return data;
  }
}
