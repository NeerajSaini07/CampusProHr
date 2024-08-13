import 'package:campus_pro/src/DATA/API_SERVICES/loadLastEmpNoApi.dart';

abstract class LoadLastEmpNoRepositoryAbs {
  Future<String> loadEmpNo(Map<String, String> userData);
}

class LoadLastEmpNoRepository extends LoadLastEmpNoRepositoryAbs {
  final LoadLastEmpNoApi _api;
  LoadLastEmpNoRepository(this._api);
  @override
  Future<String> loadEmpNo(Map<String, String?> userData) async {
    final data = await _api.loadLastEmpNo(userData);
    return data;
  }
}
