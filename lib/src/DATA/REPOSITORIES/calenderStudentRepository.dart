import 'package:campus_pro/src/DATA/API_SERVICES/activityApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/calenderStudentApi.dart';
import 'package:campus_pro/src/DATA/MODELS/activityModel.dart';
import 'package:campus_pro/src/DATA/MODELS/calenderStudentModel.dart';

abstract class CalenderStudentRepositoryAbs {
  Future<List<CalenderStudentModel>> calenderStudent(
      Map<String, String> userData);
}

class CalenderStudentRepository extends CalenderStudentRepositoryAbs {
  final CalenderStudentApi _api;
  CalenderStudentRepository(this._api);
  @override
  Future<List<CalenderStudentModel>> calenderStudent(
      Map<String, String?> userData) async {
    final data = await _api.calenderStudent(userData);
    return data;
  }
}
