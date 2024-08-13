import 'package:campus_pro/src/DATA/API_SERVICES/searchEmployeeFromRecordsCommonApi.dart';
import 'package:campus_pro/src/DATA/MODELS/searchEmployeeFromRecordsCommonModel.dart';

abstract class SearchEmployeeFromRecordsCommonRepositoryAbs {
  Future<List<SearchEmployeeFromRecordsCommonModel>> searchEmployeeKey(
      Map<String, String?> searchKey);
}

class SearchEmployeeFromRecordsCommonRepository
    extends SearchEmployeeFromRecordsCommonRepositoryAbs {
  final SearchEmployeeFromRecordsCommonApi _api;
  SearchEmployeeFromRecordsCommonRepository(this._api);

  Future<List<SearchEmployeeFromRecordsCommonModel>> searchEmployeeKey(
      Map<String, String?> searchKey) async {
    final data = await _api.searchEmployeeKey(searchKey);
    return data;
  }
}
