import 'package:campus_pro/src/DATA/API_SERVICES/activityApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/studentFeeFineApi.dart';
import 'package:campus_pro/src/DATA/MODELS/activityModel.dart';

abstract class StudentFeeFineRepositoryAbs {
  Future<String> studentFeeFine(Map<String, String> feeData);
}

class StudentFeeFineRepository extends StudentFeeFineRepositoryAbs {
  final StudentFeeFineApi _api;
  StudentFeeFineRepository(this._api);
  @override
  Future<String> studentFeeFine(Map<String, String?> feeData) async {
    final data = await _api.studentFeeFine(feeData);
    return data;
  }
}
