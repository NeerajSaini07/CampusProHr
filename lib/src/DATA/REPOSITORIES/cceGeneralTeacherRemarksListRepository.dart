import 'package:campus_pro/src/DATA/API_SERVICES/cceGeneralTeacherRemarksListApi.dart';
import 'package:campus_pro/src/DATA/MODELS/cceGeneralTeacherRemarksListModel.dart';

abstract class CceGeneralTeacherRemarksListRepositoryAbs {
  Future<List<CceGeneralTeacherRemarksListModel>> remarkData(
      Map<String, String> requestPayload);
}

class CceGeneralTeacherRemarksListRepository
    extends CceGeneralTeacherRemarksListRepositoryAbs {
  final CceGeneralTeacherRemarksListApi _api;
  CceGeneralTeacherRemarksListRepository(this._api);
  @override
  Future<List<CceGeneralTeacherRemarksListModel>> remarkData(
      Map<String, String?> requestPayload) async {
    final data = await _api.remarkData(requestPayload);
    return data;
  }
}
