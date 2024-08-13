import 'package:campus_pro/src/DATA/API_SERVICES/getSubjectAdminApi.dart';
import 'package:campus_pro/src/DATA/MODELS/getSubjectAdminModel.dart';

abstract class GetSubjectAdminRepositoryAbs {
  Future<List<GetSubjectAdminModel>> getSubject(Map<String, String?> request);
}

class GetSubjectAdminRepository extends GetSubjectAdminRepositoryAbs {
  final GetSubjectAdminApi _api;
  GetSubjectAdminRepository(this._api);
  Future<List<GetSubjectAdminModel>> getSubject(Map<String, String?> request) {
    final data = _api.getSubject(request);
    return data;
  }
}
