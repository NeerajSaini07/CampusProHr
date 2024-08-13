import 'package:campus_pro/src/DATA/API_SERVICES/teacherRemarksListApi.dart';
import 'package:campus_pro/src/DATA/MODELS/teacherRemarksListModel.dart';

abstract class TeacherRemarksListRepositoryAbs {
  Future<List<TeacherRemarksListModel>> remarkData(
      Map<String, String> requestPayload);
}

class TeacherRemarksListRepository extends TeacherRemarksListRepositoryAbs {
  final TeacherRemarksListApi _api;
  TeacherRemarksListRepository(this._api);
  @override
  Future<List<TeacherRemarksListModel>> remarkData(
      Map<String, String?> requestPayload) async {
    final data = await _api.remarkData(requestPayload);
    return data;
  }
}
