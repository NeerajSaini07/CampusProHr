import 'package:campus_pro/src/DATA/API_SERVICES/preClassExamAnalysisApi.dart';

abstract class PreClassExamAnalysisRepositoryAbs {
  Future<String> preClassExamAnalysisData(Map<String, String?> requestPayload);
}

class PreClassExamAnalysisRepository extends PreClassExamAnalysisRepositoryAbs {
  final PreClassExamAnalysisApi _api;
  PreClassExamAnalysisRepository(this._api);

  Future<String> preClassExamAnalysisData(
      Map<String, String?> requestPayload) async {
    final data = await _api.preClassExamAnalysisData(requestPayload);
    return data;
  }
}
