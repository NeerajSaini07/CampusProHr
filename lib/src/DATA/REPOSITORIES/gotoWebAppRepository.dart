import 'package:campus_pro/src/DATA/API_SERVICES/gotoWebAppApi.dart';

abstract class GotoWebAppRepositoryAbs {
  Future<String> gotoWebApp(Map<String, String?> request);
}

class  GotoWebAppRepository extends GotoWebAppRepositoryAbs {
  final GotoWebAppApi _api;
  GotoWebAppRepository(this._api);

  Future<String> gotoWebApp(Map<String, String?> request) {
    var data = _api.gotoWebAppApi(request);
    return data;
  }
}
