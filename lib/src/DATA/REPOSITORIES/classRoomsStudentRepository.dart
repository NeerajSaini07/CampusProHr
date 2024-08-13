import 'package:campus_pro/src/DATA/API_SERVICES/classRoomsStudentApi.dart';
import 'package:campus_pro/src/DATA/MODELS/classRoomsStudentModel.dart';

abstract class ClassRoomsStudentRepositoryAbs {
  Future<List<ClassRoomsStudentModel>> classRoomsData(
      Map<String, String> classData);
}

class ClassRoomsStudentRepository extends ClassRoomsStudentRepositoryAbs {
  final ClassRoomsStudentApi _api;
  ClassRoomsStudentRepository(this._api);

  Future<List<ClassRoomsStudentModel>> classRoomsData(
      Map<String, String?> classData) async {
    final data = await _api.classRoomsData(classData);
    return data;
  }
}
