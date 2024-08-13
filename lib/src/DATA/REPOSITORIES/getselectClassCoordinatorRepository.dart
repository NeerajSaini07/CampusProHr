import 'package:campus_pro/src/DATA/API_SERVICES/getSelectClassCoordinatorApi.dart';
import 'package:campus_pro/src/DATA/MODELS/getselectClassCoordinatorDropdownModel.dart';

abstract class GetSelectClassCoordinatorRepositoryAbs {
  Future<List<GetSelectClassCoordinatorModel>> getCoordinatorClass(
      Map<String, String?> request);
}

class GetSelectClassCoordinatorRepository
    extends GetSelectClassCoordinatorRepositoryAbs {
  final GetSelectClassCoordinatorApi _api;

  GetSelectClassCoordinatorRepository(this._api);

  Future<List<GetSelectClassCoordinatorModel>> getCoordinatorClass(
      Map<String, String?> request) {
    var data = _api.getCoordinatorClass(request);
    return data;
  }
}
