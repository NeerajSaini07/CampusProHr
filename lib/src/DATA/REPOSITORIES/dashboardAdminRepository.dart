import 'package:campus_pro/src/DATA/API_SERVICES/dashboardAdminApi.dart';
import 'package:campus_pro/src/DATA/MODELS/dashboardAdminModel.dart';

abstract class DashboardAdminRepositoryAbs {
  Future<DashboardAdminModel> showDashboardAdminData(
      Map<String, String?> requestPayload);
}

class DashboardAdminRepository extends DashboardAdminRepositoryAbs {
  final DashboardAdminApi _api;
  DashboardAdminRepository(this._api);
  @override
  Future<DashboardAdminModel> showDashboardAdminData(
      Map<String, String?> requestPayload) async {
    final data = await _api.dashboardAdminData(requestPayload);
    return data;
  }
}
