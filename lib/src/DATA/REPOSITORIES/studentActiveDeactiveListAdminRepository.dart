import 'package:campus_pro/src/DATA/API_SERVICES/studentActiveDeactiveListAdminApi.dart';

abstract class StudentActiveDeactiveListAdminRespositoryAbs {
  Future<bool> studentActiveDeactiveListAdmin(Map<String, String> studentData);
}

class StudentActiveDeactiveListAdminRepository
    extends StudentActiveDeactiveListAdminRespositoryAbs {
  final StudentActiveDeactiveListAdminApi _api;

  StudentActiveDeactiveListAdminRepository(this._api);
  @override
  Future<bool> studentActiveDeactiveListAdmin(
      Map<String, String> studentData) async {
    final data = await _api.studentDetail(studentData);
    return data;
  }
}
