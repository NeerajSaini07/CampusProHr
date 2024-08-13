import 'package:campus_pro/src/DATA/API_SERVICES/examMarksChartApi.dart';
import 'package:campus_pro/src/DATA/MODELS/examMarksChartModel.dart';

abstract class ExamMarksChartRepositoryAbs {
  Future<List<ExamMarksChartModel>> examMarksChart(
      Map<String, String> chartData);
}

class ExamMarksChartRepository extends ExamMarksChartRepositoryAbs {
  final ExamMarksChartApi _api;
  ExamMarksChartRepository(this._api);
  @override
  Future<List<ExamMarksChartModel>> examMarksChart(
      Map<String, String?> chartData) async {
    final data = await _api.examMarksChart(chartData);
    return data;
  }
}
