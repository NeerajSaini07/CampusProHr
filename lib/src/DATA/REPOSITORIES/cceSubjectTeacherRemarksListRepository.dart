import 'package:campus_pro/src/DATA/API_SERVICES/cceSubjectTeacherRemarksListApi.dart';
import 'package:campus_pro/src/DATA/MODELS/cceSubjectTeacherRemarksListModel.dart';

abstract class CceSubjectTeacherRemarksListRepositoryAbs {
  Future<List> remarkData(
      Map<String, String> requestPayload);
}

class CceSubjectTeacherRemarksListRepository
    extends CceSubjectTeacherRemarksListRepositoryAbs {
  final CceSubjectTeacherRemarksListApi _api;
  CceSubjectTeacherRemarksListRepository(this._api);
  @override
  Future<List> remarkData(
      Map<String, String?> requestPayload) async {
    final data = await _api.remarkData(requestPayload);
    return data;
  }
}
