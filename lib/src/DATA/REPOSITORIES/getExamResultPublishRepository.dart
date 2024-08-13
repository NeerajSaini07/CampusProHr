import 'package:campus_pro/src/DATA/API_SERVICES/getExamResultPublishApi.dart';
import 'package:campus_pro/src/DATA/MODELS/getExamResultPublishModel.dart';

abstract class GetExamResultPublishRepositoryAbs {
  Future<List<GetExamResultPublishModel>> getStudentList(
      Map<String, dynamic> request);
}

class GetExamResultPublishRepository extends GetExamResultPublishRepositoryAbs {
  final GetExamResultPublishApi api;
  GetExamResultPublishRepository(this.api);

  Future<List<GetExamResultPublishModel>> getStudentList(
      Map<String, dynamic> request) {
    final data = api.getStudentList(request);
    return data;
  }
}
