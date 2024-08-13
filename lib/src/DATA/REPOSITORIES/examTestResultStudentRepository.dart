import 'package:campus_pro/src/DATA/API_SERVICES/activityApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/examTestResultStudentApi.dart';
import 'package:campus_pro/src/DATA/MODELS/activityModel.dart';
import 'package:campus_pro/src/DATA/MODELS/examTestResultStudentModel.dart';

abstract class ExamTestResultStudentRepositoryAbs {
  Future<List<ExamTestResultStudentModel>> resultData(
      Map<String, String> userData);
}

class ExamTestResultStudentRepository
    extends ExamTestResultStudentRepositoryAbs {
  final ExamTestResultStudentApi _api;
  ExamTestResultStudentRepository(this._api);
  @override
  Future<List<ExamTestResultStudentModel>> resultData(
      Map<String, String?> userData) async {
    final data = await _api.resultData(userData);
    return data;
  }
}
