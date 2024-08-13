import 'package:campus_pro/src/DATA/API_SERVICES/examListGradeEntryApi.dart';
import 'package:campus_pro/src/DATA/MODELS/examListGradeEntryModel.dart';

abstract class ExamListGradeEntryRepositoryAbs {
  Future<List<ExamListGradeEntryModel>> gradeEntry(
      Map<String, String?> request);
}

class ExamListGradeEntryRepository extends ExamListGradeEntryRepositoryAbs {
  final ExamListGradeEntryApi _api;
  ExamListGradeEntryRepository(this._api);
  Future<List<ExamListGradeEntryModel>> gradeEntry(
      Map<String, String?> request) {
    final data = _api.gradeList(request);
    return data;
  }
}
