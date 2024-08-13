import 'package:campus_pro/src/DATA/API_SERVICES/examMarksApi.dart';
import 'package:campus_pro/src/DATA/MODELS/examMarksModel.dart';

abstract class ExamMarksRepositoryAbs {
  Future<List<ExamMarksModel>> examMarks(Map<String, String> marksData);
}

class ExamMarksRepository extends ExamMarksRepositoryAbs {
  final ExamMarksApi _api;
  ExamMarksRepository(this._api);
  @override
  Future<List<ExamMarksModel>> examMarks(Map<String, String?> marksData) async {
    final data = await _api.examMarks(marksData);
    return data;
  }
}
