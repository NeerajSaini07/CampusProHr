import 'package:campus_pro/src/DATA/API_SERVICES/schoolBusRouteApi.dart';
import 'package:campus_pro/src/DATA/MODELS/schoolBusRouteModel.dart';

abstract class SchoolBusRouteRepositoryAbs {
  Future<SchoolBusRouteModel> fetchBusRoute(Map<String, String> routeData);
}

class SchoolBusRouteRepository extends SchoolBusRouteRepositoryAbs {
  final SchoolBusRouteApi _api;
  SchoolBusRouteRepository(this._api);

  @override
  Future<SchoolBusRouteModel> fetchBusRoute(
      Map<String, String?> routeData) async {
    final data = await _api.fetchBusRoute(routeData);
    return data;
  }
}
