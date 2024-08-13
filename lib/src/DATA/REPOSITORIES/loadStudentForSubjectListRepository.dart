import 'package:campus_pro/src/DATA/API_SERVICES/loadStudentForSubjectListApi.dart';
import 'package:campus_pro/src/DATA/MODELS/loadStudentForSubjectListModel.dart';

abstract class LoadStudentForSubjectListRepositoryAbs {
  Future<List<LoadStudentForSubjectListModel>> studentList(
      Map<String, String?> request);
}

class LoadStudentForSubjectListRepository
    extends LoadStudentForSubjectListRepositoryAbs {
  final LoadStudentForSubjectListApi _api;
  LoadStudentForSubjectListRepository(this._api);

  Future<List<LoadStudentForSubjectListModel>> studentList(
      Map<String, String?> request) {
    var data = _api.studentList(request);
    return data;
  }
}
