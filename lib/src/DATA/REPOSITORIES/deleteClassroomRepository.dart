import 'package:campus_pro/src/DATA/API_SERVICES/deleteClassroomApi.dart';

abstract class DeleteClassroomRepositoryAbs {
  Future<bool> classroomData(Map<String, String> classData);
}

class DeleteClassroomRepository extends DeleteClassroomRepositoryAbs {
  final DeleteClassroomApi _api;
  DeleteClassroomRepository(this._api);

  Future<bool> classroomData(Map<String, String?> classData) async {
    final data = await _api.classroomData(classData);
    return data;
  }
}
