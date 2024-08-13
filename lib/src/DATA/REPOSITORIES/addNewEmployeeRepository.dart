import 'package:campus_pro/src/DATA/API_SERVICES/addNewEmployeeApi.dart';

abstract class AddNewEmployeeRepositoryAbs {
  Future<String> addNewEmployee(Map<String, String> userData);
}

class AddNewEmployeeRepository extends AddNewEmployeeRepositoryAbs {
  final AddNewEmployeeApi _api;
  AddNewEmployeeRepository(this._api);
  @override
  Future<String> addNewEmployee(Map<String, String?> userData) async {
    final data = await _api.addNewEmployee(userData);
    return data;
  }
}
