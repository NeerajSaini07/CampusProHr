import 'package:campus_pro/src/DATA/API_SERVICES/dayClosingDataApi.dart';
import 'package:campus_pro/src/DATA/MODELS/dayClosingDataModel.dart';

abstract class DayClosingDataRepositoryAbs {
  Future<DayClosingDataModel> dayClosingDataData(
      Map<String, String?> requestPayload);
}

class DayClosingDataRepository extends DayClosingDataRepositoryAbs {
  final DayClosingDataApi _api;
  DayClosingDataRepository(this._api);

  Future<DayClosingDataModel> dayClosingDataData(
      Map<String, String?> requestPayload) async {
    final data = await _api.dayClosingDataData(requestPayload);
    return data;
  }
}
