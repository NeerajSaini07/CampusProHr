import 'package:campus_pro/src/DATA/API_SERVICES/homeworkEmployeeApi.dart';
import 'package:campus_pro/src/DATA/MODELS/homeworkEmployeeModel.dart';

abstract class HomeworkEmployeeRepositoryAbs {
  Future<List<HomeworkEmployeeModel>> homeworkData(
      Map<String, String> classData);
}

class HomeworkEmployeeRepository extends HomeworkEmployeeRepositoryAbs {
  final HomeworkEmployeeApi _api;
  HomeworkEmployeeRepository(this._api);

  Future<List<HomeworkEmployeeModel>> homeworkData(
      Map<String, String?> classData) async {
    final data = await _api.homeworkData(classData);
    return data;
  }
}