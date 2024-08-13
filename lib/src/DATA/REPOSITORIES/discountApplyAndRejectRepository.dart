import 'package:campus_pro/src/DATA/API_SERVICES/discountApplyAndRejectApi.dart';

abstract class DiscountApplyAndRejectRepositoryAbs {
  Future<bool> discountApplyAndRejectData(
      Map<String, String?> requestPayload);
}

class DiscountApplyAndRejectRepository extends DiscountApplyAndRejectRepositoryAbs {
  final DiscountApplyAndRejectApi _api;
  DiscountApplyAndRejectRepository(this._api);

  Future<bool> discountApplyAndRejectData(
      Map<String, String?> requestPayload) async {
    final data = await _api.discountApplyAndRejectData(requestPayload);
    return data;
  }
}
