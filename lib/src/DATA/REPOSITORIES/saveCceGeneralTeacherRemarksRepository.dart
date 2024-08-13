import 'package:campus_pro/src/DATA/API_SERVICES/saveCceGeneralTeacherRemarksApi.dart';

abstract class SaveCceGeneralTeacherRemarksRepositoryAbs {
  Future<bool> remarkData(Map<String, String> requestPayload);
}

class SaveCceGeneralTeacherRemarksRepository
    extends SaveCceGeneralTeacherRemarksRepositoryAbs {
  final SaveCceGeneralTeacherRemarksApi _api;
  SaveCceGeneralTeacherRemarksRepository(this._api);
  @override
  Future<bool> remarkData(Map<String, String?> requestPayload) async {
    final data = await _api.remarkData(requestPayload);
    return data;
  }
}
