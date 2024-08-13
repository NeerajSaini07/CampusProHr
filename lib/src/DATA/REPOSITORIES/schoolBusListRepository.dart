import 'package:campus_pro/src/DATA/API_SERVICES/schoolBusListApi.dart';
import 'package:campus_pro/src/DATA/MODELS/schoolBusListModel.dart';

abstract class SchoolBusListRepositoryAbs {
  Future<List<SchoolBusListModel>> busInfoData(Map<String, String> busData);
}

class SchoolBusListRepository extends SchoolBusListRepositoryAbs {
  final SchoolBusListApi _api;
  SchoolBusListRepository(this._api);

  @override
  Future<List<SchoolBusListModel>> busInfoData(
      Map<String, String?> busData) async {
    final data = await _api.busInfoData(busData);
    return data;
  }
}
