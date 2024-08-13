import 'package:campus_pro/src/DATA/API_SERVICES/markSheetStudentApi.dart';
import 'package:campus_pro/src/DATA/MODELS/markSheetModel.dart';

abstract class MarkSheetStudentRepositoryAbs {
  Future<List<MarkSheetStudentModel>> loadMarkSheetData(
      Map<String, String> requestPayload);
}

class MarkSheetStudentRepository extends MarkSheetStudentRepositoryAbs {
  final MarkSheetStudentApi _api;
  MarkSheetStudentRepository(this._api);

  Future<List<MarkSheetStudentModel>> loadMarkSheetData(
      Map<String, String?> requestPayload) async {
    final data = await _api.loadMarkSheetData(requestPayload);
    return data;
  }
}
