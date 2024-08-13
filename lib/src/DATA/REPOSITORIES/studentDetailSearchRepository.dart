import 'package:campus_pro/src/DATA/API_SERVICES/studentDetailSearchApi.dart';
import 'package:campus_pro/src/DATA/MODELS/studentDetailSearchModel.dart';

abstract class StudentDetailSearchRespositoryAbs {
  Future<StudentDetailSearchModel> studentDetailSearch(
      Map<String, String?> studentData);
}

class StudentDetailSearchRepository extends StudentDetailSearchRespositoryAbs {
  final StudentDetailSearchApi _api;

  StudentDetailSearchRepository(this._api);
  @override
  Future<StudentDetailSearchModel> studentDetailSearch(
      Map<String, String?> studentData) async {
    final data = await _api.studentDetail(studentData);
    return data;
  }
}
