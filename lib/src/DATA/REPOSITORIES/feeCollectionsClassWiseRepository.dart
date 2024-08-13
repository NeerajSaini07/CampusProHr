import 'package:campus_pro/src/DATA/API_SERVICES/feeCollectionsClassWiseApi.dart';
import 'package:campus_pro/src/DATA/MODELS/feeCollectionsClassWiseModel.dart';

abstract class FeeCollectionsClassWiseRepositoryAbs {
  Future<List<FeeCollectionsClassWiseModel>> feeCollectionsClassWiseData(
      Map<String, String?> requestPayload);
}

class FeeCollectionsClassWiseRepository extends FeeCollectionsClassWiseRepositoryAbs {
  final FeeCollectionsClassWiseApi _api;
  FeeCollectionsClassWiseRepository(this._api);

  Future<List<FeeCollectionsClassWiseModel>> feeCollectionsClassWiseData(
      Map<String, String?> requestPayload) async {
    final data = await _api.feeCollectionsClassWiseData(requestPayload);
    return data;
  }
}
