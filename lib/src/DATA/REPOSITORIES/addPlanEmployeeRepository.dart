import 'package:campus_pro/src/DATA/API_SERVICES/sendHomeWorkEmployeeApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/addPlanEmployeeApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/sendClassRoomCommentApi.dart';

abstract class AddPlanRepositoryAbs {
  Future<String> addPlanEmployee(Map<String, String?> userData);
}

class AddPlanEmployeeRepository extends AddPlanRepositoryAbs {
  final AddPlanEmployeeApi _api;
  AddPlanEmployeeRepository(this._api);
  @override
  Future<String> addPlanEmployee(Map<String, String?> userData) {
    final data = _api.addPlanEmployee(userData);
    return data;
  }
}
