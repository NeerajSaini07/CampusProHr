import 'package:campus_pro/src/DATA/API_SERVICES/subjectExamMarkApi.dart';
import 'package:campus_pro/src/DATA/MODELS/subjectExamMarkModel.dart';

abstract class SubjectExamMarksRepositoryAbs {
  Future<List<SubjectExamMarksModel>> subjectData(
      Map<String, String> requestPayload);
}

class SubjectExamMarksRepository extends SubjectExamMarksRepositoryAbs {
  final SubjectExamMarksApi _api;
  SubjectExamMarksRepository(this._api);
  @override
  Future<List<SubjectExamMarksModel>> subjectData(
      Map<String, String?> requestPayload) async {
    final data = await _api.subjectData(requestPayload);
    return data;
  }
}
