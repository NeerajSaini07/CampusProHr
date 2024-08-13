import 'package:campus_pro/src/DATA/API_SERVICES/getClasswiseSubjectAdminApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/getComplainSuggestionListAdminApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/markAttendanceListEmployeeApi.dart';
import 'package:campus_pro/src/DATA/MODELS/getClasswiseSubjectAdminModel.dart';
import 'package:campus_pro/src/DATA/MODELS/getComplainSuggestionListAdminModel.dart';
import 'package:campus_pro/src/DATA/MODELS/markAttendanceListEmployeeModel.dart';

abstract class GetComplainSuggestionListAdminRepositoryAbs {
  Future<List<GetComplainSuggestionListAdminModel>> getSuggestionList(
      Map<String, String> requestPayload);
}

class GetComplainSuggestionListAdminRepository
    extends GetComplainSuggestionListAdminRepositoryAbs {
  final GetComplainSuggestionListAdminApi _api;
  GetComplainSuggestionListAdminRepository(this._api);

  Future<List<GetComplainSuggestionListAdminModel>> getSuggestionList(
      Map<String, String?> requestPayload) async {
    final data = await _api.getSuggestionList(requestPayload);
    return data;
  }
}
