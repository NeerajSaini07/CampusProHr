import 'package:campus_pro/src/DATA/API_SERVICES/deleteCustomChatApi.dart';

abstract class DeleteCustomChatRepositoryAbs {
  Future<bool> deleteCustomChatData(Map<String, String> classData);
}

class DeleteCustomChatRepository extends DeleteCustomChatRepositoryAbs {
  final DeleteCustomChatApi _api;
  DeleteCustomChatRepository(this._api);

  Future<bool> deleteCustomChatData(Map<String, String?> classData) async {
    final data = await _api.deleteCustomChatData(classData);
    return data;
  }
}