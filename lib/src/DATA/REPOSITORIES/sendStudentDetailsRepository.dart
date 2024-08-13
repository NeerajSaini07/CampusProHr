import 'package:campus_pro/src/DATA/API_SERVICES/sendStudentDetailsApi.dart';

abstract class SendStudentDetailsRespositoryAbs {
  Future<bool> sendStudent(Map<String, String?> studentData);
}

class SendStudentDetailsRepository
    extends SendStudentDetailsRespositoryAbs {
  final SendStudentDetailsApi _api;

  SendStudentDetailsRepository(this._api);
  @override
  Future<bool> sendStudent(
      Map<String, String?> studentData) async {
    final data = await _api.sendDetail(studentData);
    return data;
  }
}
