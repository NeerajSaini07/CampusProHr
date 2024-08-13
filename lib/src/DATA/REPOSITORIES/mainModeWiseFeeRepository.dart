import 'package:campus_pro/src/DATA/API_SERVICES/mainModeWiseFeeApi.dart';
import 'package:campus_pro/src/DATA/MODELS/mainModeWiseFeeModel.dart';

abstract class MainModeWiseFeeRepositoryAbs {
  Future<List<MainModeWiseFeeModel>> mainModeWiseFeeData(
      Map<String, String?> requestPayload);
}

class MainModeWiseFeeRepository extends MainModeWiseFeeRepositoryAbs {
  final MainModeWiseFeeApi _api;
  MainModeWiseFeeRepository(this._api);

  Future<List<MainModeWiseFeeModel>> mainModeWiseFeeData(
      Map<String, String?> requestPayload) async {
    final data = await _api.mainModeWiseFeeData(requestPayload);
    return data;
  }
}
