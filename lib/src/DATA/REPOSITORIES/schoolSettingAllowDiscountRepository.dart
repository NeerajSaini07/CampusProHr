import 'package:campus_pro/src/DATA/API_SERVICES/schoolSettingAllowDiscountApi.dart';

abstract class SchoolSettingAllowDiscountRepositoryAbs {
  Future<String> schoolSettingAllowDiscountData(
      Map<String, String?> requestPayload);
}

class SchoolSettingAllowDiscountRepository
    extends SchoolSettingAllowDiscountRepositoryAbs {
  final SchoolSettingAllowDiscountApi _api;
  SchoolSettingAllowDiscountRepository(this._api);

  Future<String> schoolSettingAllowDiscountData(
      Map<String, String?> requestPayload) async {
    final data = await _api.schoolSettingAllowDiscountData(requestPayload);
    return data;
  }
}
