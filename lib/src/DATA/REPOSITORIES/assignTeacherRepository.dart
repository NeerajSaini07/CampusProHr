import 'package:campus_pro/src/DATA/API_SERVICES/assignTeacherApi.dart';
import 'package:campus_pro/src/DATA/MODELS/assignTeacherModel.dart';

abstract class AssignTeacherRepositoryAbs {
  Future<List<AssignTeacherModel>> assignTeacher(
      Map<String, String> assignData);
}

class AssignTeacherRepository extends AssignTeacherRepositoryAbs {
  final AssignTeacherApi _api;
  AssignTeacherRepository(this._api);
  @override
  Future<List<AssignTeacherModel>> assignTeacher(
      Map<String, String?> assignData) async {
    final data = await _api.assignTeacher(assignData);
    return data;
  }
}
