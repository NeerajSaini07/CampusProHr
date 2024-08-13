import 'package:campus_pro/src/DATA/API_SERVICES/getUserAssignMenuApi.dart';
import 'package:campus_pro/src/DATA/MODELS/getUserAssignMenuModel.dart';

abstract class GetUserAssignMenuRepositoryAbs {
  Future<List<GetUserAssignMenuModel>> getAssignMenu(
      Map<String, String?> request);
}

class GetUserAssignMenuRepository extends GetUserAssignMenuRepositoryAbs {
  final GetUserAssignMenuApi _api;
  GetUserAssignMenuRepository(this._api);

  Future<List<GetUserAssignMenuModel>> getAssignMenu(
      Map<String, String?> request) async {
    final data = await _api.getAssignMenu(request);
    return data;
  }
}
