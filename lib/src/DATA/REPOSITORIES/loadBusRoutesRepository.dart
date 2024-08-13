import 'package:campus_pro/src/DATA/MODELS/loadBusRoutesModel.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/loadBusRoutesApi.dart';

abstract class LoadBusRoutesRepositoryAbs {
  Future<List<LoadBusRoutesModel>> getBusRoutes(Map<String, String?> request);
}

class LoadBusRoutesRepository extends LoadBusRoutesRepositoryAbs {
  final LoadBusRoutesApi _api;
  LoadBusRoutesRepository(this._api);

  Future<List<LoadBusRoutesModel>> getBusRoutes(Map<String, String?> request) {
    final data = _api.getBusRoutes(request);
    return data;
  }
}
