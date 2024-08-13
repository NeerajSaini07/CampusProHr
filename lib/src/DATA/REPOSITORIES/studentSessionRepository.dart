import 'package:campus_pro/src/DATA/API_SERVICES/assignTeacherApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/studentSessionApi.dart';
import 'package:campus_pro/src/DATA/MODELS/assignTeacherModel.dart';
import 'package:campus_pro/src/DATA/MODELS/studentSessionModel.dart';

abstract class StudentSessionRepositoryAbs {
  Future<List<StudentSessionModel>> studentSession(
      Map<String, String> sessionData);
}

class StudentSessionRepository extends StudentSessionRepositoryAbs {
  final StudentSessionApi _api;
  StudentSessionRepository(this._api);
  @override
  Future<List<StudentSessionModel>> studentSession(
      Map<String, String?> sessionData) async {
    final data = await _api.studentSession(sessionData);
    return data;
  }
}
