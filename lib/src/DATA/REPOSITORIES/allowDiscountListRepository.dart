import 'package:campus_pro/src/DATA/API_SERVICES/allowDiscountListApi.dart';
import 'package:campus_pro/src/DATA/MODELS/allowDiscountListModel.dart';

abstract class AllowDiscountListRepositoryAbs {
  Future<List<AllowDiscountListModel>> allowDiscountListData(
      Map<String, String?> requestPayload);
}

class AllowDiscountListRepository extends AllowDiscountListRepositoryAbs {
  final AllowDiscountListApi _api;
  AllowDiscountListRepository(this._api);

  Future<List<AllowDiscountListModel>> allowDiscountListData(
      Map<String, String?> requestPayload) async {
    final data = await _api.allowDiscountListData(requestPayload);
    return data;
  }
}
