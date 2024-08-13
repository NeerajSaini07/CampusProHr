import 'package:campus_pro/src/DATA/MODELS/getGradeModel.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/getGradeApi.dart';

abstract class GetGradeRepositoryAbs {
  Future<List<GetGradeModel>> getGrade(Map<String, String?> request);
}

class GetGradeRepository extends GetGradeRepositoryAbs {
  final GetGradeApi _api;
  GetGradeRepository(this._api);

  Future<List<GetGradeModel>> getGrade(Map<String, String?> request) {
    var data = _api.getGrade(request);
    return data;
  }
}
