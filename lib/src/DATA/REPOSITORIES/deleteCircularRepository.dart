import 'package:campus_pro/src/DATA/API_SERVICES/deleteCircularApi.dart';

abstract class DeleteCircularRepositoryAbs {
  Future<bool> deleteData(Map<String, String> requestPayload);
}

class DeleteCircularRepository extends DeleteCircularRepositoryAbs {
  final DeleteCircularApi _api;
  DeleteCircularRepository(this._api);
  @override
  Future<bool> deleteData(Map<String, String?> requestPayload) async {
    final data = await _api.deleteData(requestPayload);
    return data;
  }
}
