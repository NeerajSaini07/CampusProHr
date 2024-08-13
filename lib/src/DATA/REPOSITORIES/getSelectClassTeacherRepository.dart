import 'package:campus_pro/src/DATA/API_SERVICES/getselectClassTeacherApi.dart';

abstract class GetSelectClassTeacherRepositoryAbs {
  Future<List> getClassTeacherSelect(Map<String, String?> request);
}

class GetSelectClassTeacherRepository
    extends GetSelectClassTeacherRepositoryAbs {
  final GetSelectClassTeacherApi _api;
  GetSelectClassTeacherRepository(this._api);

  Future<List> getClassTeacherSelect(Map<String, String?> request) {
    final data = _api.getClassTeacherSelect(request);
    return data;
  }
}
