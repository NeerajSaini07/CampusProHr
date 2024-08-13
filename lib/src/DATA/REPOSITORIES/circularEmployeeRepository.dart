import 'package:campus_pro/src/DATA/API_SERVICES/circularEmployeeApi.dart';
import 'package:campus_pro/src/DATA/MODELS/circularEmployeeModel.dart';

abstract class CircularEmployeeRepositoryAbs {
  Future<List<CircularEmployeeModel>> circularEmployeeData(
      Map<String, String> requestPayload);
}

class CircularEmployeeRepository extends CircularEmployeeRepositoryAbs {
  final CircularEmployeeApi _api;
  CircularEmployeeRepository(this._api);
  @override
  Future<List<CircularEmployeeModel>> circularEmployeeData(
      Map<String, String?> requestPayload) async {
    final data = await _api.circularEmployeeData(requestPayload);
    return data;
  }
}
