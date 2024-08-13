import 'package:campus_pro/src/DATA/API_SERVICES/removeAllottedSubjectsApi.dart';

abstract class RemoveAllottedSubjectsRepositoryAbs {
  Future<String> removeSubject(Map<String, String?> request);
}

class RemoveAllottedSubjectsRepository
    implements RemoveAllottedSubjectsRepositoryAbs {
  final RemoveAllottedSubjectsApi _api;
  RemoveAllottedSubjectsRepository(this._api);

  Future<String> removeSubject(Map<String, String?> request) {
    final data = _api.removeSubject(request);
    return data;
  }
}
