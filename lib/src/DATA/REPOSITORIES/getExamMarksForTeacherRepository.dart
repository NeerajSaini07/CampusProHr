import 'package:campus_pro/src/DATA/API_SERVICES/getExamMarksForTeacherApi.dart';
import 'package:campus_pro/src/DATA/MODELS/getExamMarksForTeacherModel.dart';

abstract class GetExamMarksForTeacherRepositoryAbs {
  Future<List<GetExamMarksForTeacherModel>> getExamMarks(
      Map<String, String?> request);
}

class GetExamMarksForTeacherRepository
    extends GetExamMarksForTeacherRepositoryAbs {
  final GetExamMarksForTeacherApi _api;
  GetExamMarksForTeacherRepository(this._api);
  Future<List<GetExamMarksForTeacherModel>> getExamMarks(
      Map<String, String?> request) {
    final data = _api.getExamMarks(request);
    return data;
  }
}
