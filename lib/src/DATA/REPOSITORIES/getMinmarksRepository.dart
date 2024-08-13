import 'package:campus_pro/src/DATA/MODELS/getMinMaxmarksModel.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/getMinmarksApi.dart';

abstract class GetMinMaxmarksRepositoryAbs {
  Future<List<GetMinMaxmarksModel>> getMinMaxMarks(
      Map<String, String?> request);
}

class GetMinMaxmarksRepository extends GetMinMaxmarksRepositoryAbs {
  final GetMinMaxMarksApi api;
  GetMinMaxmarksRepository(this.api);

  Future<List<GetMinMaxmarksModel>> getMinMaxMarks(
      Map<String, String?> request) {
    final data = api.getMinMaxMarks(request);
    return data;
  }
}
