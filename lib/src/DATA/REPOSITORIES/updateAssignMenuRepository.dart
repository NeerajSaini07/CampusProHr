import 'package:campus_pro/src/DATA/API_SERVICES/updateAssignMenuApi.dart';

abstract class UpdateAssignMenuRepositoryAbs {
  Future<String> updateMenu(Map<String, String?> request);
}

class UpdateAssignMenuRepository extends UpdateAssignMenuRepositoryAbs {
  final UpdateAssignMenuApi _api;
  UpdateAssignMenuRepository(this._api);

  Future<String> updateMenu(Map<String, String?> request) {
    final data = _api.updateMenu(request);
    return data;
  }
}
