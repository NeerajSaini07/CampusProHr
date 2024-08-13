import 'package:campus_pro/src/DATA/API_SERVICES/teacherListSubjectWiseApi.dart';
import 'package:campus_pro/src/DATA/MODELS/teacherListSubjectWiseModel.dart';

abstract class TeacherListSubjectWiseRepositoryAbs {
  Future<List<TeacherListSubjectWiseModel>> getSubject(
      Map<String, String> requestPayload);
}

class TeacherListSubjectWiseRepository
    extends TeacherListSubjectWiseRepositoryAbs {
  final TeacherListSubjectWiseApi _api;
  TeacherListSubjectWiseRepository(this._api);

  Future<List<TeacherListSubjectWiseModel>> getSubject(
      Map<String, String?> requestPayload) async {
    final data = await _api.teacherList(requestPayload);
    return data;
  }
}
