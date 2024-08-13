import 'package:campus_pro/src/DATA/API_SERVICES/assignAdminApi.dart';
import 'package:campus_pro/src/DATA/MODELS/assignAdminModel.dart';

abstract class AssignAdminRepositoryAbs {
  Future<List<AssignAdminModel>> assign(Map<String, String?> request);
}

class AssignAdminRepository extends AssignAdminRepositoryAbs {
  final AssignAdminApi _api;
  AssignAdminRepository(this._api);
  Future<List<AssignAdminModel>> assign(Map<String, String?> request) {
    final data = _api.assignAdmin(request);
    return data;
  }
}
