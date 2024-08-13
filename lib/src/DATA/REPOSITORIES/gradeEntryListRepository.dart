import 'package:campus_pro/src/DATA/API_SERVICES/gradeEntryListApi.dart';
import 'package:campus_pro/src/DATA/MODELS/gradeEntryListModel.dart';

abstract class GradeEntryListRepositoryAbs {
  Future<List<GradeEntryListModel>> gradeEntry(Map<String, String?> request);
}

class GradeEntryListRepository extends GradeEntryListRepositoryAbs {
  final GradeEntryListApi _api;
  GradeEntryListRepository(this._api);
  Future<List<GradeEntryListModel>> gradeEntry(Map<String, String?> request) {
    final data = _api.gradeList(request);
    return data;
  }
}
