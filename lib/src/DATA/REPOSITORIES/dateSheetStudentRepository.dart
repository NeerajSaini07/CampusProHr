import 'package:campus_pro/src/DATA/API_SERVICES/dateSheetStudentApi.dart';
import 'package:campus_pro/src/DATA/MODELS/dateSheetStudentModel.dart';

abstract class DateSheetStudentRepositoryAbs {
  Future<List<DateSheetStudentModel>> getDateSheet(
      Map<String, String?> datesheetData);
}

class DateSheetStudentRepository extends DateSheetStudentRepositoryAbs {
  final DateSheetStudentApi _api;
  DateSheetStudentRepository(this._api);

  @override
  Future<List<DateSheetStudentModel>> getDateSheet(
      Map<String, String?> datesheetData) async {
    final data = await _api.getDateSheet(datesheetData);
    return data;
  }
}
