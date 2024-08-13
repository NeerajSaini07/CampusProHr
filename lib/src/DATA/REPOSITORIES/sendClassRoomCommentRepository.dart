import 'dart:io';

import 'package:campus_pro/src/DATA/API_SERVICES/assignTeacherApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/sendClassRoomCommentApi.dart';
import 'package:campus_pro/src/DATA/MODELS/assignTeacherModel.dart';

abstract class SendClassRoomCommentRepositoryAbs {
  Future<bool> sendClassRoomComment(
      Map<String, String> commentData, List<File>? _filePickedList);
}

class SendClassRoomCommentRepository extends SendClassRoomCommentRepositoryAbs {
  final SendClassRoomCommentApi _api;
  SendClassRoomCommentRepository(this._api);
  @override
  Future<bool> sendClassRoomComment(
      Map<String, String> commentData, List<File>? _filePickedList) async {
    final data = await _api.sendClassRoomComments(commentData, _filePickedList);
    return data;
  }
}
