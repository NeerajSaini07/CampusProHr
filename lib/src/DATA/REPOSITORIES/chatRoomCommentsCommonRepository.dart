import 'package:campus_pro/src/DATA/API_SERVICES/chatRoomCommentsCommonApi.dart';
import 'package:campus_pro/src/DATA/MODELS/classRoomCommentsModel.dart';
import 'package:campus_pro/src/DATA/MODELS/customChatModel.dart';
import 'package:campus_pro/src/DATA/MODELS/homeWorkCommentsModel.dart';

abstract class ChatRoomCommentsCommonRepositoryAbs {
  Future<List<ClassRoomCommentsModel>> classRoomComments(
      Map<String, String?> commentData);
  Future<HomeWorkCommentsModel> homeworkComments(
      Map<String, String?> commentData);
  Future<List<CustomChatModel>> customChatData(
      Map<String, String?> commentData);
}

class ChatRoomCommentsCommonRepository
    extends ChatRoomCommentsCommonRepositoryAbs {
  final ChatRoomCommentsCommonApi _api;
  ChatRoomCommentsCommonRepository(this._api);

  @override
  Future<List<ClassRoomCommentsModel>> classRoomComments(
      Map<String, String?> commentData) async {
    final data = await _api.classRoomComments(commentData);
    return data;
  }

  @override
  Future<HomeWorkCommentsModel> homeworkComments(
      Map<String, String?> commentData) async {
    final data = await _api.homeworkComments(commentData);
    return data;
  }

  @override
  Future<List<CustomChatModel>> customChatData(
      Map<String, String?> commentData) async {
    final data = await _api.customChatData(commentData);
    return data;
  }
}
