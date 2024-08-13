import 'package:campus_pro/src/DATA/API_SERVICES/getExamTypeAdminApi.dart';
import 'package:campus_pro/src/DATA/MODELS/getExamTypeAdminModel.dart';

abstract class GetExamTypeAdminRepositoryAbs {
  Future<List<GetExamTypeAdminModel>> getExam(Map<String, String?> request);
}

class GetExamTypeAdminRepository extends GetExamTypeAdminRepositoryAbs {
  final GetExamTypeAdminApi _api;
  GetExamTypeAdminRepository(this._api);

  Future<List<GetExamTypeAdminModel>> getExam(Map<String, String?> request) {
    final data = _api.getExam(request);
    return data;
  }
}
