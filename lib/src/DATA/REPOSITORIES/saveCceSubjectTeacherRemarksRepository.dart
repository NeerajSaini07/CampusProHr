import 'package:campus_pro/src/DATA/API_SERVICES/saveCceSubjectTeacherRemarksApi.dart';

abstract class SaveCceSubjectTeacherRemarksRepositoryAbs {
  Future<bool> remarkData(Map<String, String> requestPayload);
}

class SaveCceSubjectTeacherRemarksRepository
    extends SaveCceSubjectTeacherRemarksRepositoryAbs {
  final SaveCceSubjectTeacherRemarksApi _api;
  SaveCceSubjectTeacherRemarksRepository(this._api);
  @override
  Future<bool> remarkData(Map<String, String?> requestPayload) async {
    final data = await _api.remarkData(requestPayload);
    return data;
  }
}