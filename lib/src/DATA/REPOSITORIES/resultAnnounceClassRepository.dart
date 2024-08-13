import 'package:campus_pro/src/DATA/API_SERVICES/resultAnnounceClassApi.dart';
import 'package:campus_pro/src/DATA/MODELS/resultAnnounceClassModel.dart';

abstract class ResultAnnounceClassRepositoryAbs {
  Future<List<ResultAnnounceClassModel>> getClass(Map<String, dynamic> request);
}

class ResultAnnounceClassRepository extends ResultAnnounceClassRepositoryAbs {
  final ResultAnnounceClassApi api;
  ResultAnnounceClassRepository(this.api);

  Future<List<ResultAnnounceClassModel>> getClass(
      Map<String, dynamic> request) async {
    final data = await api.getClass(request);
    return data;
  }
}
