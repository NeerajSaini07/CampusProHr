import 'package:campus_pro/src/DATA/API_SERVICES/profileStudentApi.dart';
import 'package:campus_pro/src/DATA/MODELS/profileStudentModel.dart';

abstract class ProfileStudentRepositoryAbs {
  Future<List<ProfileStudentModel>> profileData(
      Map<String, String> requestPayload);
}

class ProfileStudentRepository extends ProfileStudentRepositoryAbs {
  final ProfileStudentApi _api;
  ProfileStudentRepository(this._api);

  Future<List<ProfileStudentModel>> profileData(
      Map<String, String?> requestPayload) async {
    final data = await _api.profileData(requestPayload);
    return data;
  }
}
