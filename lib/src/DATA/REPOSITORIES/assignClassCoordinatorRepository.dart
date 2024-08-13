import 'dart:io';

import 'package:campus_pro/src/DATA/API_SERVICES/assignClassCoordinatorApi.dart';

abstract class AssignClassCoordinatorRepositoryAbs {
  Future<String> saveClassCoordinator(
      Map<String, String> request, List<File>? img);
}

class AssignClassCoordinatorRepository
    extends AssignClassCoordinatorRepositoryAbs {
  final AssignClassCoordinatorApi _api;
  AssignClassCoordinatorRepository(this._api);

  Future<String> saveClassCoordinator(
      Map<String, String> request, List<File>? img) {
    var data = _api.saveCoordinator(request, img);
    return data;
  }
}
