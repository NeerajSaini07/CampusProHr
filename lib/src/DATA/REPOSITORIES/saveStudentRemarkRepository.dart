import 'package:campus_pro/src/DATA/API_SERVICES/saveStudentRemarkApi.dart';

abstract class SaveStudentRemarkRepositoryAbs {
  Future<bool> saveRemark(Map<String, String?> saveData);
}

class SaveStudentRemarkRepository extends SaveStudentRemarkRepositoryAbs {
  final SaveStudentRemarkApi _api;
  SaveStudentRemarkRepository(this._api);

  Future<bool> saveRemark(Map<String, String?> saveData) async {
    final data = await _api.saveRemark(saveData);
    return data;
  }
}
