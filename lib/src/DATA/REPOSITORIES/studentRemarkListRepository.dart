import 'package:campus_pro/src/DATA/API_SERVICES/studentRemarkListApi.dart';
import 'package:campus_pro/src/DATA/MODELS/studentRemarkListModel.dart';

abstract class StudentRemarkListRepositoryAbs {
  Future<List<StudentRemarkListModel>> studentRemark(
      Map<String, String?> remarkData);
}

class StudentRemarkListRepository extends StudentRemarkListRepositoryAbs {
  final StudentRemarkListApi _api;
  StudentRemarkListRepository(this._api);

  Future<List<StudentRemarkListModel>> studentRemark(
      Map<String, String?> remarkData) async {
    final data = await _api.studentRemark(remarkData);
    return data;
  }
}
