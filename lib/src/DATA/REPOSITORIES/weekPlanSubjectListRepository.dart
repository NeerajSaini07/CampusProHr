import 'package:campus_pro/src/DATA/API_SERVICES/weekPlanSubjectListApi.dart';
import 'package:campus_pro/src/DATA/MODELS/weekPlanSubjectListModel.dart';

abstract class WeekPlanSubjectListRepositoryAbs {
  Future<List<WeekPlanSubjectListModel>> getSubject(
      Map<String, String> requestPayload);
}

class WeekPlanSubjectListRepository extends WeekPlanSubjectListRepositoryAbs {
  final WeekPlanSubjectListApi _api;
  WeekPlanSubjectListRepository(this._api);

  Future<List<WeekPlanSubjectListModel>> getSubject(
      Map<String, String?> requestPayload) async {
    final data = await _api.getSubject(requestPayload);
    return data;
  }
}
