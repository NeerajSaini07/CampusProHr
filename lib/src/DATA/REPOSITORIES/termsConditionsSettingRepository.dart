import 'package:campus_pro/src/DATA/API_SERVICES/activityApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/termsConditionsSettingApi.dart';
import 'package:campus_pro/src/DATA/MODELS/activityModel.dart';

abstract class TermsConditionsSettingRepositoryAbs {
  Future<String> termsConditionsSetting(
      Map<String, String> termsConditionsSettingData);
}

class TermsConditionsSettingRepository
    extends TermsConditionsSettingRepositoryAbs {
  final TermsConditionsSettingApi _api;
  TermsConditionsSettingRepository(this._api);
  @override
  Future<String> termsConditionsSetting(
      Map<String, String?> termsConditionsSettingData) async {
    final data = await _api.termsConditionsSetting(termsConditionsSettingData);
    return data;
  }
}
