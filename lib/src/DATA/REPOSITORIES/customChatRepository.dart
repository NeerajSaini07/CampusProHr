import 'package:campus_pro/src/DATA/API_SERVICES/customChatApi.dart';
import 'package:campus_pro/src/DATA/MODELS/customChatModel.dart';

abstract class CustomChatRepositoryAbs {
  Future<List<CustomChatModel>> customChatData(
      Map<String, String> classData);
}

class CustomChatRepository extends CustomChatRepositoryAbs {
  final CustomChatApi _api;
  CustomChatRepository(this._api);

  Future<List<CustomChatModel>> customChatData(
      Map<String, String?> classData) async {
    final data = await _api.customChatData(classData);
    return data;
  }
}
