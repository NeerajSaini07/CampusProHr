import 'package:campus_pro/src/DATA/API_SERVICES/circularStudentApi.dart';
import 'package:campus_pro/src/DATA/MODELS/circularStudentModel.dart';

abstract class CircularStudentRepositoryAbs {
  Future<List<CircularStudentModel>> circularStudentData(
      Map<String, String> requestPayload);
}

class CircularStudentRepository extends CircularStudentRepositoryAbs {
  final CircularStudentApi _api;
  CircularStudentRepository(this._api);

  Future<List<CircularStudentModel>> circularStudentData(
      Map<String, String?> requestPayload) async {
    final data = await _api.circularStudentData(requestPayload);
    return data;
  }
}
