import 'package:campus_pro/src/DATA/API_SERVICES/customChatUserListApi.dart';
import 'package:campus_pro/src/DATA/MODELS/customChatUserListModel.dart';

abstract class CustomChatUserListRepositoryAbs {
  Future<List<CustomChatUserListModel>> customChatData(
      Map<String, String> classData);
}

class CustomChatUserListRepository extends CustomChatUserListRepositoryAbs {
  final CustomChatUserListApi _api;
  CustomChatUserListRepository(this._api);

  Future<List<CustomChatUserListModel>> customChatData(
      Map<String, String?> classData) async {
    final data = await _api.customChatData(classData);
    return data;
  }
}
