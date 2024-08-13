import 'package:campus_pro/src/DATA/API_SERVICES/classroomEmployeeApi.dart';
import 'package:campus_pro/src/DATA/MODELS/classroomEmployeeModel.dart';

abstract class ClassroomEmployeeRepositoryAbs {
  Future<List<ClassroomEmployeeModel>> classroomData(
      Map<String, String> classData);
}

class ClassroomEmployeeRepository extends ClassroomEmployeeRepositoryAbs {
  final ClassroomEmployeeApi _api;
  ClassroomEmployeeRepository(this._api);

  Future<List<ClassroomEmployeeModel>> classroomData(
      Map<String, String?> classData) async {
    final data = await _api.classroomData(classData);
    return data;
  }
}