import 'package:campus_pro/src/DATA/API_SERVICES/examAnalysisLineChartApi.dart';
import 'package:campus_pro/src/DATA/MODELS/examAnalysisLineChartModel.dart';

abstract class ExamAnalysisLineChartRepositoryAbs {
  Future<ExamAnalysisLineChartModel> examAnalysisLineChart(
      Map<String, String> examData);
}

class ExamAnalysisLineChartRepository extends ExamAnalysisLineChartRepositoryAbs {
  final ExamAnalysisLineChartApi _api;
  ExamAnalysisLineChartRepository(this._api);
  @override
  Future<ExamAnalysisLineChartModel> examAnalysisLineChart(
      Map<String, String?> examData) async {
    final data = await _api.examAnalysisLineChart(examData);
    return data;
  }
}
