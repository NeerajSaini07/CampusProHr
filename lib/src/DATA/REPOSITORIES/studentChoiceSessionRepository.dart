import 'package:campus_pro/src/DATA/API_SERVICES/assignTeacherApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/studentChoiceSessionApi.dart';
import 'package:campus_pro/src/DATA/MODELS/assignTeacherModel.dart';

abstract class StudentChoiceSessionRepositoryAbs {
  Future<String> studentChoiceSession(Map<String, String> sessionData);
}

class StudentChoiceSessionRepository extends StudentChoiceSessionRepositoryAbs {
  final StudentChoiceSessionApi _api;
  StudentChoiceSessionRepository(this._api);
  @override
  Future<String> studentChoiceSession(Map<String, String?> sessionData) async {
    final data = await _api.studentChoiceSession(sessionData);
    return data;
  }
}
