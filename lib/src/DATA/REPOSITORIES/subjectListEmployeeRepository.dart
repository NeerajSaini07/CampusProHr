import 'package:campus_pro/src/DATA/API_SERVICES/subjectListEmployeeApi.dart';
import 'package:campus_pro/src/DATA/MODELS/SubjectListEmployeeModel.dart';

abstract class SubjectListEmployeeRepositoryAbs {
  Future<List<SubjectListEmployeeModel>> getSubject(
      Map<String, String> requestPayload);
}

class SubjectListEmployeeRepository extends SubjectListEmployeeRepositoryAbs {
  final SubjectListEmployeeApi _api;
  SubjectListEmployeeRepository(this._api);

  Future<List<SubjectListEmployeeModel>> getSubject(
      Map<String, String?> requestPayload) async {
    final data = await _api.getSubject(requestPayload);
    return data;
  }
}
