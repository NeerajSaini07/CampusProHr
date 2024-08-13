import 'package:campus_pro/src/DATA/API_SERVICES/classesForCoordinatorApi.dart';
import 'package:campus_pro/src/DATA/MODELS/classesForCoordinatorModel.dart';

abstract class ClassesForCoordinatorRepositoryAbs {
  Future<List<ClassesForCoordinatorModel>> getClass(
      Map<String, String?> request);
}

class ClassesForCoordinatorRepository
    extends ClassesForCoordinatorRepositoryAbs {
  final ClassesForCoordinatorApi _api;

  ClassesForCoordinatorRepository(this._api);

  Future<List<ClassesForCoordinatorModel>> getClass(
      Map<String, String?> request) {
    var data = _api.getClasses(request);
    return data;
  }
}
