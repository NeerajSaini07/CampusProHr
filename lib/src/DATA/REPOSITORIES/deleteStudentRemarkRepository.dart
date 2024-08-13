import 'package:campus_pro/src/DATA/API_SERVICES/deleteStudentRemarkApi.dart';

abstract class DeleteStudentRemarkRepositoryAbs {
  Future<bool> deleteRemark(Map<String, String?> deleteData);
}

class DeleteStudentRemarkRepository extends DeleteStudentRemarkRepositoryAbs {
  final DeleteStudentRemarkApi _api;
  DeleteStudentRemarkRepository(this._api);

  Future<bool> deleteRemark(Map<String, String?> deleteData) async {
    final data = await _api.deleteRemark(deleteData);
    return data;
  }
}
