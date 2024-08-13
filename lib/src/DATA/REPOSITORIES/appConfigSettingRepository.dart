import 'package:campus_pro/src/DATA/API_SERVICES/appConfigSettingApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/assignTeacherApi.dart';
import 'package:campus_pro/src/DATA/MODELS/appConfigSettingModel.dart';
import 'package:campus_pro/src/DATA/MODELS/assignTeacherModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';

abstract class AppConfigSettingRepositoryAbs {
  Future<AppConfigSettingModel> appConfigSetting(
      Map<String, String> settingData);
}

class AppConfigSettingRepository extends AppConfigSettingRepositoryAbs {
  final AppConfigSettingApi _api;
  AppConfigSettingRepository(this._api);
  @override
  Future<AppConfigSettingModel> appConfigSetting(
      Map<String, String?> settingData) async {
    final data = await _api.appConfigSetting(settingData);
    await UserUtils.cacheAppConfig(data);
    return data;
  }
}
