import 'package:campus_pro/src/DATA/API_SERVICES/searchStudentFromRecordsCommonApi.dart';
import 'package:campus_pro/src/DATA/MODELS/searchStudentFromRecordsCommonModel.dart';

abstract class SearchStudentFromRecordsCommonRepositoryAbs {
  Future<List<SearchStudentFromRecordsCommonModel>> searchStudentKey(
      Map<String, String?> remarkData);
}

class SearchStudentFromRecordsCommonRepository
    extends SearchStudentFromRecordsCommonRepositoryAbs {
  final SearchStudentFromRecordsCommonApi _api;
  SearchStudentFromRecordsCommonRepository(this._api);

  Future<List<SearchStudentFromRecordsCommonModel>> searchStudentKey(
      Map<String, String?> remarkData) async {
    final data = await _api.searchStudentKey(remarkData);
    return data;
  }
}
