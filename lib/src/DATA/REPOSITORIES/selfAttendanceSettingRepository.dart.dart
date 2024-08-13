import 'package:campus_pro/src/DATA/API_SERVICES/assignTeacherApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/selfAttendanceSettingApi.dart';
import 'package:campus_pro/src/DATA/MODELS/assignTeacherModel.dart';
import 'package:campus_pro/src/DATA/MODELS/selfAttendanceSettingModel.dart';

abstract class SelfAttendanceSettingRepositoryAbs {
  Future<bool> selfAttendanceSetting(Map<String, String> schoolData);
}

class SelfAttendanceSettingRepository
    extends SelfAttendanceSettingRepositoryAbs {
  final SelfAttendanceSettingApi _api;
  SelfAttendanceSettingRepository(this._api);
  @override
  Future<bool> selfAttendanceSetting(Map<String, String?> schoolData) async {
    final data = await _api.selfAttendanceSetting(schoolData);
    return data;
  }
}
