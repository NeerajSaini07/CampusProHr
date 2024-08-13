import 'package:campus_pro/src/DATA/API_SERVICES/assignPeriodAdminApi.dart';

abstract class AssignPeriodAdminRepositoryAbs {
  Future<String> assignPeriod(Map<String, String?> request);
}

class AssignPeriodAdminRepository extends AssignPeriodAdminRepositoryAbs {
  final AssignPeriodAdminApi _api;
  AssignPeriodAdminRepository(this._api);

  Future<String> assignPeriod(Map<String, String?> request) {
    final data = _api.assignPeriod(request);
    return data;
  }
}
