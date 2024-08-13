import 'package:campus_pro/src/DATA/API_SERVICES/subjectListMeetingApi.dart';
import 'package:campus_pro/src/DATA/MODELS/subjectListMeetingModel.dart';

abstract class SubjectListMeetingRepositoryAbs {
  Future<List<SubjectListMeetingModel>> subjectList(
      Map<String, String> subjectData);
}

class SubjectListMeetingRepository extends SubjectListMeetingRepositoryAbs {
  final SubjectListMeetingApi _api;
  SubjectListMeetingRepository(this._api);
  @override
  Future<List<SubjectListMeetingModel>> subjectList(
      Map<String, String?> subjectData) async {
    final data = await _api.subjectList(subjectData);
    return data;
  }
}
