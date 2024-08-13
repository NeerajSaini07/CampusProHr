import 'dart:io';

import 'package:campus_pro/src/DATA/API_SERVICES/assignTeacherApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/sendCustomClassRoomCommentApi.dart';
import 'package:campus_pro/src/DATA/MODELS/assignTeacherModel.dart';

abstract class SendCustomClassRoomCommentRepositoryAbs {
  Future<bool> sendCustomClassRoomComment(
      Map<String, String> commentData, List<File>? _filePickedList);
}

class SendCustomClassRoomCommentRepository
    extends SendCustomClassRoomCommentRepositoryAbs {
  final SendCustomClassRoomCommentApi _api;
  SendCustomClassRoomCommentRepository(this._api);
  @override
  Future<bool> sendCustomClassRoomComment(
      Map<String, String> commentData, List<File>? _filePickedList) async {
    final data =
        await _api.sendCustomClassRoomComments(commentData, _filePickedList);
    return data;
  }
}
