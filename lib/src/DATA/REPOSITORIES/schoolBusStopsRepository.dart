import 'package:campus_pro/src/DATA/API_SERVICES/schoolBusStopsApi.dart';
import 'package:campus_pro/src/DATA/MODELS/schoolBusStopsModel.dart';

abstract class SchoolBusStopsRepositoryAbs {
  Future<List<SchoolBusStopsModel>> busInfoData(Map<String, String> busData);
}

class SchoolBusStopsRepository extends SchoolBusStopsRepositoryAbs {
  final SchoolBusStopsApi _api;
  SchoolBusStopsRepository(this._api);

  @override
  Future<List<SchoolBusStopsModel>> busInfoData(
      Map<String, String?> busData) async {
    final data = await _api.busInfoData(busData);
    return data;
  }
}
