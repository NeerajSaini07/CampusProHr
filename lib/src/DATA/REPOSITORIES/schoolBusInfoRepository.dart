import 'package:campus_pro/src/DATA/API_SERVICES/schoolBusInfoApi.dart';
import 'package:campus_pro/src/DATA/MODELS/schoolBusInfoModel.dart';

abstract class SchoolBusInfoRepositoryAbs {
  Future<SchoolBusInfoModel> busInfoData(Map<String, String> busData);
}

class SchoolBusInfoRepository extends SchoolBusInfoRepositoryAbs {
  final SchoolBusInfoApi _api;
  SchoolBusInfoRepository(this._api);

  @override
  Future<SchoolBusInfoModel> busInfoData(Map<String, String?> busData) async {
    final data = await _api.busInfoData(busData);
    return data;
  }
}
