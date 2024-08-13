import 'package:campus_pro/src/DATA/API_SERVICES/deleteHomeworkApi.dart';

abstract class DeleteHomeworkRepositoryAbs {
  Future<bool> homeworkData(Map<String, String> classData);
}

class DeleteHomeworkRepository extends DeleteHomeworkRepositoryAbs {
  final DeleteHomeworkApi _api;
  DeleteHomeworkRepository(this._api);

  Future<bool> homeworkData(Map<String, String?> classData) async {
    final data = await _api.homeworkData(classData);
    return data;
  }
}
