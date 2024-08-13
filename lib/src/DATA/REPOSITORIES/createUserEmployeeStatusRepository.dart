import 'package:campus_pro/src/DATA/API_SERVICES/createUserEmployeeStatusApi.dart';

abstract class CreateUserEmployeeStatusRespositoryAbs {
  Future<bool> createStatus(Map<String, String?> createData);
}

class CreateUserEmployeeStatusRepository
    extends CreateUserEmployeeStatusRespositoryAbs {
  final CreateUserEmployeeStatusApi _api;

  CreateUserEmployeeStatusRepository(this._api);
  @override
  Future<bool> createStatus(Map<String, String?> createData) async {
    final data = await _api.createStatus(createData);
    return data;
  }
}
