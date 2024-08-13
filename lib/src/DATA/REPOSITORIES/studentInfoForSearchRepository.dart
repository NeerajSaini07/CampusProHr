import 'package:campus_pro/src/DATA/API_SERVICES/studentInfoForSearchApi.dart';
import 'package:campus_pro/src/DATA/MODELS/studentInfoForSearchModel.dart';

abstract class StudentInfoForSearchRepositoryAbs {
  Future<StudentInfoForSearchModel> getStudentInfoForSearch(Map<String, String> studentData);
}

class StudentInfoForSearchRepository extends StudentInfoForSearchRepositoryAbs {
  final StudentInfoForSearchApi _api;
  StudentInfoForSearchRepository(this._api);

  @override
  Future<StudentInfoForSearchModel> getStudentInfoForSearch(
      Map<String, String> studentData) async {
    final data = await _api.getStudentInfoForSearch(studentData);
    return data;
  }
}
