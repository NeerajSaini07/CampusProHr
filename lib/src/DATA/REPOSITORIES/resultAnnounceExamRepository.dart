import 'package:campus_pro/src/DATA/API_SERVICES/resultAnnounceClassApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/resultAnnounceExamApi.dart';
import 'package:campus_pro/src/DATA/MODELS/resultAnnounceClassModel.dart';
import 'package:campus_pro/src/DATA/MODELS/resultAnnounceExamModel.dart';

abstract class ResultAnnounceExamRepositoryAbs {
  Future<List<ResultAnnounceExamModel>> getExam(Map<String, dynamic> request);
}

class ResultAnnounceExamRepository extends ResultAnnounceExamRepositoryAbs {
  final ResultAnnounceExamApi api;
  ResultAnnounceExamRepository(this.api);

  Future<List<ResultAnnounceExamModel>> getExam(
      Map<String, dynamic> request) async {
    final data = await api.getExam(request);
    return data;
  }
}
