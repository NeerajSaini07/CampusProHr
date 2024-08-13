import 'package:campus_pro/src/DATA/API_SERVICES/saveGardeEntryApi.dart';

abstract class SaveGradeEntryRepositoryAbs {
  Future<bool> gradeEntry(Map<String, String?> request);
}

class SaveGradeEntryRepository extends SaveGradeEntryRepositoryAbs {
  final SaveGradeEntryApi _api;
  SaveGradeEntryRepository(this._api);
  Future<bool> gradeEntry(Map<String, String?> request) {
    final data = _api.gradeList(request);
    return data;
  }
}
