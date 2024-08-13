import 'package:campus_pro/src/DATA/API_SERVICES/activityApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/examAnalysisChartApi.dart';
import 'package:campus_pro/src/DATA/MODELS/activityModel.dart';
import 'package:campus_pro/src/DATA/MODELS/examAnalysisChartModel.dart';

abstract class ExamAnalysisChartRepositoryAbs {
  Future<List<ExamAnalysisChartModel>> examAnalysisChart(
      Map<String, String> examData);
}

class ExamAnalysisChartRepository extends ExamAnalysisChartRepositoryAbs {
  final ExamAnalysisChartApi _api;
  ExamAnalysisChartRepository(this._api);
  @override
  Future<List<ExamAnalysisChartModel>> examAnalysisChart(
      Map<String, String?> examData) async {
    final data = await _api.examAnalysisChart(examData);
    return data;
  }
}
