import 'package:campus_pro/src/DATA/API_SERVICES/teacherStatusListApi.dart';
import 'package:campus_pro/src/DATA/MODELS/teacherStatusListModel.dart';

abstract class TeacherStatusListRepositoryAbs {
  Future<List<TeacherStatusListModel>> teacherList(
      Map<String, String> requestPayload);
}

class TeacherStatusListRepository extends TeacherStatusListRepositoryAbs {
  final TeachersStatusListApi _api;
  TeacherStatusListRepository(this._api);
  @override
  Future<List<TeacherStatusListModel>> teacherList(
      Map<String, String?> requestPayload) async {
    final data = await _api.teacherList(requestPayload);
    return data;
  }
}
