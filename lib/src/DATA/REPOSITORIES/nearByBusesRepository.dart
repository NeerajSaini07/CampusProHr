import 'package:campus_pro/src/DATA/API_SERVICES/nearByBusesApi.dart';
import 'package:campus_pro/src/DATA/MODELS/nearByBusesModel.dart';

abstract class NearByBusesRepositoryAbs {
  Future<List<NearByBusesModel>> nearByBusesData(
      Map<String, String?> requestPayload);
}

class NearByBusesRepository extends NearByBusesRepositoryAbs {
  final NearByBusesApi _api;
  NearByBusesRepository(this._api);

  Future<List<NearByBusesModel>> nearByBusesData(
      Map<String, String?> requestPayload) async {
    final data = await _api.nearByBusesData(requestPayload);
    return data;
  }
}