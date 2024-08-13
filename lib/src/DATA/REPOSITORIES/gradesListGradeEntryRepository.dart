import 'package:campus_pro/src/DATA/API_SERVICES/gradesListGradeEntryApi.dart';
import 'package:campus_pro/src/DATA/MODELS/gradesListGradeEntryModel.dart';

abstract class GradeListGradeEntryRepositoryAbs {
  Future<List<GradesListGradeEntryModel>> gradeEntry(
      Map<String, String?> request);
}

class GradeListGradeEntryRepository extends GradeListGradeEntryRepositoryAbs {
  final GradeListGradeEntryApi _api;
  GradeListGradeEntryRepository(this._api);
  Future<List<GradesListGradeEntryModel>> gradeEntry(
      Map<String, String?> request) {
    final data = _api.gradeList(request);
    return data;
  }
}
