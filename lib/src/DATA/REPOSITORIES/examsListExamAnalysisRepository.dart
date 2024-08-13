import 'package:campus_pro/src/DATA/API_SERVICES/activityApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/examsListExamAnalysisApi.dart';
import 'package:campus_pro/src/DATA/MODELS/activityModel.dart';
import 'package:campus_pro/src/DATA/MODELS/examsListExamAnalysisModel.dart';

abstract class ExamsListExamAnalysisRepositoryAbs {
  Future<List<ExamsListExamAnalysisModel>> examsListExamAnalysis(
      Map<String, String> examData);
}

class ExamsListExamAnalysisRepository extends ExamsListExamAnalysisRepositoryAbs {
  final ExamsListExamAnalysisApi _api;
  ExamsListExamAnalysisRepository(this._api);
  @override
  Future<List<ExamsListExamAnalysisModel>> examsListExamAnalysis(
      Map<String, String?> examData) async {
    final data = await _api.examsListExamAnalysis(examData);
    return data;
  }
}
