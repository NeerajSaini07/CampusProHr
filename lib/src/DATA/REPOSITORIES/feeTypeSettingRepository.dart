import 'package:campus_pro/src/DATA/API_SERVICES/activityApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/feeTypeSettingApi.dart';
import 'package:campus_pro/src/DATA/MODELS/activityModel.dart';

abstract class FeeTypeSettingRepositoryAbs {
  Future<String> feeTypeSetting(Map<String, String> feeTypeSettingData);
}

class FeeTypeSettingRepository extends FeeTypeSettingRepositoryAbs {
  final FeeTypeSettingApi _api;
  FeeTypeSettingRepository(this._api);
  @override
  Future<String> feeTypeSetting(Map<String, String?> feeTypeSettingData) async {
    final data = await _api.feeTypeSetting(feeTypeSettingData);
    return data;
  }
}
