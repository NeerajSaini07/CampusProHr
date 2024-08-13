import 'package:campus_pro/src/DATA/API_SERVICES/subjectListExamAnalysisApi.dart';
import 'package:campus_pro/src/DATA/MODELS/subjectListExamAnalysisModel.dart';

abstract class SubjectListExamAnalysisRepositoryAbs {
  Future<List<SubjectListExamAnalysisModel>> subjectListExamAnalysisData(
      Map<String, String?> requestPayload);
}

class SubjectListExamAnalysisRepository
    extends SubjectListExamAnalysisRepositoryAbs {
  final SubjectListExamAnalysisApi _api;
  SubjectListExamAnalysisRepository(this._api);

  Future<List<SubjectListExamAnalysisModel>> subjectListExamAnalysisData(
      Map<String, String?> requestPayload) async {
    final data = await _api.subjectListExamAnalysisData(requestPayload);
    return data;
  }
}
