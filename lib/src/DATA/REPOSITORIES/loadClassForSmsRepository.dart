import 'package:campus_pro/src/DATA/API_SERVICES/loadClassForSmsApi.dart';
import 'package:campus_pro/src/DATA/MODELS/loadClassForSmsModel.dart';

abstract class LoadClassForSmsRepositoryAbs {
  Future<List<LoadClassForSmsModel>> getClass(Map<String, String?> request);
}

class LoadClassForSmsRepository extends LoadClassForSmsRepositoryAbs {
  final LoadClassForSmsApi _api;
  LoadClassForSmsRepository(this._api);

  Future<List<LoadClassForSmsModel>> getClass(
      Map<String, String?> request) async {
    final data = await _api.getClass(request);
    return data;
  }
}
