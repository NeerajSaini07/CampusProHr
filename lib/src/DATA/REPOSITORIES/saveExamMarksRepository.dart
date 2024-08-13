import 'package:campus_pro/src/DATA/API_SERVICES/saveExamMarkApi.dart';

abstract class SaveExamMarksRepositoryAbs {
  Future<bool> saveData(Map<String, String> requestPayload);
}

class SaveExamMarksRepository extends SaveExamMarksRepositoryAbs {
  final SaveExamMarksApi _api;
  SaveExamMarksRepository(this._api);
  @override
  Future<bool> saveData(Map<String, String?> requestPayload) async {
    final data = await _api.subjectData(requestPayload);
    return data;
  }
}
