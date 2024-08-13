import 'package:campus_pro/src/DATA/API_SERVICES/deleteUserEmployeeStatusApi.dart';

abstract class DeleteUserEmployeeStatusRespositoryAbs {
  Future<bool> deleteStatus(Map<String, String?> deleteData);
}

class DeleteUserEmployeeStatusRepository
    extends DeleteUserEmployeeStatusRespositoryAbs {
  final DeleteUserEmployeeStatusApi _api;

  DeleteUserEmployeeStatusRepository(this._api);
  @override
  Future<bool> deleteStatus(Map<String, String?> deleteData) async {
    final data = await _api.deleteStatus(deleteData);
    return data;
  }
}
