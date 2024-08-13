import 'package:campus_pro/src/DATA/API_SERVICES/loadClassForSubjectAdminApi.dart';
import 'package:campus_pro/src/DATA/MODELS/loadClassForSubjectAdminModel.dart';

abstract class LoadClassForSubjectAdminRepositoryAbs {
  Future<List<LoadClassForSubjectAdminModel>> getClass(
      Map<String, String?> request);
}

class LoadClassForSubjectAdminRepository
    extends LoadClassForSubjectAdminRepositoryAbs {
  final LoadClassForSubjectAdminApi _api;
  LoadClassForSubjectAdminRepository(this._api);
  Future<List<LoadClassForSubjectAdminModel>> getClass(
      Map<String, String?> request) {
    final data = _api.getClass(request);
    return data;
  }
}
