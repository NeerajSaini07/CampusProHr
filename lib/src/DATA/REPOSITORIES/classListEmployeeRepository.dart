import 'package:campus_pro/src/DATA/API_SERVICES/classListEmployeeApi.dart';
import 'package:campus_pro/src/DATA/MODELS/classListEmployeeModel.dart';

abstract class ClassListEmployeeRepositoryAbs {
  Future<List<ClassListEmployeeModel>> getClass(
      Map<String, String> requestPayload);
}

class ClassListEmployeeRepository extends ClassListEmployeeRepositoryAbs {
  final ClassListEmployeeApi _api;
  ClassListEmployeeRepository(this._api);

  Future<List<ClassListEmployeeModel>> getClass(
      Map<String, String?> requestPayload) async {
    final data = await _api.getClass(requestPayload);
    return data;
  }
}
