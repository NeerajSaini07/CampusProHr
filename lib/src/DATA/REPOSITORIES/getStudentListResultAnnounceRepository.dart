import 'package:campus_pro/src/DATA/API_SERVICES/getStudentListResultAnnounceApi.dart';
import 'package:campus_pro/src/DATA/MODELS/getStudentListResultAnnounceModel.dart';

abstract class GetStudentListResultAnnounceRepositoryAbs {
  Future<List<GetStudentListResultAnnounceModel>> getStudentList(
      Map<String, String?> request);
}

class GetStudentListResultAnnounceRepository
    extends GetStudentListResultAnnounceRepositoryAbs {
  final GetStudentListResultAnnounceApi _api;
  GetStudentListResultAnnounceRepository(this._api);

  Future<List<GetStudentListResultAnnounceModel>> getStudentList(
      Map<String, String?> request) {
    var data = _api.getStudentList(request);
    return data;
  }
}
