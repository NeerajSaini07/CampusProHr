import 'package:campus_pro/src/DATA/API_SERVICES/updateRollNoEmployeeApi.dart';

abstract class UpdateRollNoEmployeeRepositoryAbs {
  Future<String> updateRollNo(Map<String, String?> request);
}

class UpdateRollNoEmployeeRepository extends UpdateRollNoEmployeeRepositoryAbs {
  final UpdateRollNoEmployeeApi _api;

  UpdateRollNoEmployeeRepository(this._api);

  Future<String> updateRollNo(Map<String, String?> request) {
    var data = _api.updateRollNo(request);
    return data;
  }
}
