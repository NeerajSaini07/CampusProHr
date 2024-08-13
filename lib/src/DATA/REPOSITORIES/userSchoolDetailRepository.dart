import 'package:campus_pro/src/DATA/API_SERVICES/userSchoolDetailApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/account_type_api.dart';
import 'package:campus_pro/src/DATA/MODELS/userSchoolDetailModel.dart';
import 'package:campus_pro/src/DATA/MODELS/userTypeModel.dart';

abstract class UserSchoolDetailRepositoryAbs {
  Future<UserSchoolDetailModel> getUserSchool(Map<String, String> userData);
}

class UserSchoolDetailRepository extends UserSchoolDetailRepositoryAbs {
  final UserSchoolDetailApi _api;
  UserSchoolDetailRepository(this._api);

  @override
  Future<UserSchoolDetailModel> getUserSchool(
      Map<String, String> userData) async {
    final data = await _api.getUserSchool(userData);
    return data;
  }
}
