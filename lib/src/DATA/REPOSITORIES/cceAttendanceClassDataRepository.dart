import 'package:campus_pro/src/DATA/API_SERVICES/cceAttendanceClassDataApi.dart';
import 'package:campus_pro/src/DATA/MODELS/cceAttendanceClassDataModel.dart';

abstract class CceAttendanceClassDataRepositoryAbs {
  Future<List<CceAttendanceClassDataModel>> getClassData(
      Map<String, String?> request);
}

class CceAttendanceClassDataRepository
    extends CceAttendanceClassDataRepositoryAbs {
  final CceAttendanceClassDataApi _api;
  CceAttendanceClassDataRepository(this._api);

  Future<List<CceAttendanceClassDataModel>> getClassData(
      Map<String, String?> request) {
    var data = _api.getClassData(request);
    return data;
  }
}
