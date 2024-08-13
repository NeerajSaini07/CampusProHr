import 'package:campus_pro/src/DATA/API_SERVICES/StudentListForChangeRollNoApi.dart';
import 'package:campus_pro/src/DATA/MODELS/studentListForChangeRollNoModel.dart';

abstract class StudentListForChangeRollNoRepositoryAbs {
  Future<List<StudentListForChangeRollNoModel>> getStudentList(
      Map<String, String?> request);
}

class StudentListForChangeRollNoRepository
    extends StudentListForChangeRollNoRepositoryAbs {
  final StudentListForChangeRollNoApi _api;
  StudentListForChangeRollNoRepository(this._api);

  Future<List<StudentListForChangeRollNoModel>> getStudentList(
      Map<String, String?> request) {
    var data = _api.getStudentList(request);
    return data;
  }
}
