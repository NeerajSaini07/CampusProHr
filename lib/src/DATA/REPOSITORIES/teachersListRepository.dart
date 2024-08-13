import 'package:campus_pro/src/DATA/API_SERVICES/assignTeacherApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/teachersListApi.dart';
import 'package:campus_pro/src/DATA/MODELS/assignTeacherModel.dart';
import 'package:campus_pro/src/DATA/MODELS/teachersListModel.dart';

abstract class TeachersListRepositoryAbs {
  Future<List<TeachersListModel>> teacherList(Map<String, String> teacherData);
}

class TeachersListRepository extends TeachersListRepositoryAbs {
  final TeachersListApi _api;
  TeachersListRepository(this._api);
  @override
  Future<List<TeachersListModel>> teacherList(
      Map<String, String?> teacherData) async {
    final data = await _api.teacherList(teacherData);
    return data;
  }
}
