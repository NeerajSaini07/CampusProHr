import 'package:campus_pro/src/DATA/API_SERVICES/loadAllottedSubjectsApi.dart';
import 'package:campus_pro/src/DATA/MODELS/loadAllottedSubjectsModel.dart';

abstract class LoadAllottedSubjectsRepositoryAbs {
  Future<List<LoadAllottedSubjectsModel>> getAllotedSubject(
      Map<String, String?> request);
}

class LoadAllottedSubjectsRepository extends LoadAllottedSubjectsRepositoryAbs {
  final LoadAllottedSubjectsApi _api;
  LoadAllottedSubjectsRepository(this._api);

  Future<List<LoadAllottedSubjectsModel>> getAllotedSubject(
      Map<String, String?> request) {
    final data = _api.getAllotedSubject(request);
    return data;
  }
}
