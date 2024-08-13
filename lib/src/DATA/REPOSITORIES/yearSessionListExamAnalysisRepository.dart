import 'package:campus_pro/src/DATA/API_SERVICES/activityApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/yearSessionListExamAnalysisApi.dart';
import 'package:campus_pro/src/DATA/MODELS/activityModel.dart';
import 'package:campus_pro/src/DATA/MODELS/yearSessionListExamAnalysisModel.dart';

abstract class YearSessionListExamAnalysisRepositoryAbs {
  Future<List<YearSessionListExamAnalysisModel>> yearSessionListExamAnalysis(
      Map<String, String> yearData);
}

class YearSessionListExamAnalysisRepository extends YearSessionListExamAnalysisRepositoryAbs {
  final YearSessionListExamAnalysisApi _api;
  YearSessionListExamAnalysisRepository(this._api);
  @override
  Future<List<YearSessionListExamAnalysisModel>> yearSessionListExamAnalysis(
      Map<String, String?> yearData) async {
    final data = await _api.yearSessionListExamAnalysis(yearData);
    return data;
  }
}
