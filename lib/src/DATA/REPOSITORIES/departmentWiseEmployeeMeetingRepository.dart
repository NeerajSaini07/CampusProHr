import 'package:campus_pro/src/DATA/API_SERVICES/departmentWiseEmployeeMeetingApi.dart';
import 'package:campus_pro/src/DATA/MODELS/departmentWiseEmployeeMeetingModel.dart';

abstract class DepartmentWiseEmployeeMeetingRepositoryAbs {
  Future<List<DepartmentWiseEmployeeMeetingModel>> getDepartments(Map<String, String> departmentData);
}

class DepartmentWiseEmployeeMeetingRepository extends DepartmentWiseEmployeeMeetingRepositoryAbs {
  final DepartmentWiseEmployeeMeetingApi _api;
  DepartmentWiseEmployeeMeetingRepository(this._api);
  @override
  Future<List<DepartmentWiseEmployeeMeetingModel>> getDepartments(Map<String, String?> departmentData) async {
    final data = await _api.getDepartments(departmentData);
    return data;
  }
}