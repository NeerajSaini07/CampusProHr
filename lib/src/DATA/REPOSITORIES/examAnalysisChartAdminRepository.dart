import 'package:campus_pro/src/DATA/API_SERVICES/examAnalysisChartAdminApi.dart';
import 'package:campus_pro/src/DATA/MODELS/examAnalysisChartAdminModel.dart';

abstract class ExamAnalysisChartAdminRepositoryAbs {
  Future<List<ExamAnalysisChartAdminModel>> examAnalysisChartAdminData(
      Map<String, String?> requestPayload);
}

class ExamAnalysisChartAdminRepository
    extends ExamAnalysisChartAdminRepositoryAbs {
  final ExamAnalysisChartAdminApi _api;
  ExamAnalysisChartAdminRepository(this._api);

  Future<List<ExamAnalysisChartAdminModel>> examAnalysisChartAdminData(
      Map<String, String?> requestPayload) async {
    final data = await _api.examAnalysisChartAdminData(requestPayload);
    return data;
  }
}
