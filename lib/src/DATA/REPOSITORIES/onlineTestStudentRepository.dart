import 'package:campus_pro/src/DATA/API_SERVICES/onlineTestStudentApi.dart';

abstract class OnlineTestStudentRepositoryAbs {
  Future<String> onlineTestStudent(
      Map<String, String> testData);
}

class OnlineTestStudentRepository extends OnlineTestStudentRepositoryAbs {
  final OnlineTestStudentApi _api;
  OnlineTestStudentRepository(this._api);
  @override
  Future<String> onlineTestStudent(
      Map<String, String> testData) async {
    final data = await _api.onlineTestStudent(testData);
    return data;
  }
}
