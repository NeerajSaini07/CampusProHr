import 'package:campus_pro/src/DATA/API_SERVICES/homeWorkStudentApi.dart';
import 'package:campus_pro/src/DATA/MODELS/homeWorkStudentModel.dart';

abstract class HomeWorkStudentRepositoryAbs {
  Future<List<HomeWorkStudentModel>> homeWorkData(
      Map<String, String> requestPayload);
}

class HomeWorkStudentRepository extends HomeWorkStudentRepositoryAbs {
  final HomeWorkStudentApi _api;
  HomeWorkStudentRepository(this._api);

  Future<List<HomeWorkStudentModel>> homeWorkData(
      Map<String, String?> requestPayload) async {
    final data = await _api.homeWorkData(requestPayload);
    return data;
  }
}
