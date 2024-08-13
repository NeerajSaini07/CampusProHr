import 'package:campus_pro/src/DATA/API_SERVICES/attendanceEmployeeApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/subjectListEmployeeApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/updatePlanEmployeeApi.dart';
import 'package:campus_pro/src/DATA/MODELS/SubjectListEmployeeModel.dart';
import 'package:campus_pro/src/DATA/MODELS/attendanceEmployeeModel.dart';
import 'package:campus_pro/src/DATA/MODELS/updatePlanEmployeeModel.dart';

abstract class UpdatePlanEmployeeRepositoryAbs {
  Future<List<UpdatePlanEmployeeModel>> getPlanList(
      Map<String, String> requestPayload);
}

class UpdatePlanEmployeeRepository extends UpdatePlanEmployeeRepositoryAbs {
  final UpdatePlanEmployeeApi _api;
  UpdatePlanEmployeeRepository(this._api);

  Future<List<UpdatePlanEmployeeModel>> getPlanList(
      Map<String, String?> requestPayload) async {
    final data = await _api.updatePlanEmployee(requestPayload);
    return data;
  }
}
