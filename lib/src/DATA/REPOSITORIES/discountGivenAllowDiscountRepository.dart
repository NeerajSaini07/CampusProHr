import 'package:campus_pro/src/DATA/API_SERVICES/discountGivenAllowDiscountApi.dart';
import 'package:campus_pro/src/DATA/MODELS/discountGivenAllowDiscountModel.dart';

abstract class DiscountGivenAllowDiscountRepositoryAbs {
  Future<List<DiscountGivenAllowDiscountModel>> discountGivenAllowDiscountData(
      Map<String, String?> requestPayload);
}

class DiscountGivenAllowDiscountRepository
    extends DiscountGivenAllowDiscountRepositoryAbs {
  final DiscountGivenAllowDiscountApi _api;
  DiscountGivenAllowDiscountRepository(this._api);

  Future<List<DiscountGivenAllowDiscountModel>> discountGivenAllowDiscountData(
      Map<String, String?> requestPayload) async {
    final data = await _api.discountGivenAllowDiscountData(requestPayload);
    return data;
  }
}
