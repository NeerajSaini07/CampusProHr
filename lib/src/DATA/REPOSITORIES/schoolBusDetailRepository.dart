import 'package:campus_pro/src/DATA/API_SERVICES/schoolBusDetailApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/schoolBusRouteApi.dart';
import 'package:campus_pro/src/DATA/MODELS/schoolBusDetailModel.dart';
import 'package:campus_pro/src/DATA/MODELS/schoolBusRouteModel.dart';

abstract class SchoolBusDetailRepositoryAbs {
  Future<SchoolBusDetailModel> busInfoData(Map<String, String> busData);
}

class SchoolBusDetailRepository extends SchoolBusDetailRepositoryAbs {
  final SchoolBusDetailApi _api;
  SchoolBusDetailRepository(this._api);

  @override
  Future<SchoolBusDetailModel> busInfoData(Map<String, String?> busData) async {
    final data = await _api.busInfoData(busData);
    return data;
  }
}
