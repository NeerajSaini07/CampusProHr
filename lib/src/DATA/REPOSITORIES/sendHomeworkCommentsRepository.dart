import 'dart:io';

import 'package:campus_pro/src/DATA/API_SERVICES/assignTeacherApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/sendHomeworkCommentsApi.dart';
import 'package:campus_pro/src/DATA/MODELS/assignTeacherModel.dart';
import 'package:file_picker/file_picker.dart';

abstract class SendHomeworkCommentRepositoryAbs {
  Future<bool> sendHomeworkComment(
      Map<String, String> commentData, List<File>? _filePickedList);
}

class SendHomeworkCommentRepository extends SendHomeworkCommentRepositoryAbs {
  final SendHomeworkCommentApi _api;
  SendHomeworkCommentRepository(this._api);
  @override
  Future<bool> sendHomeworkComment(
      Map<String, String> commentData, List<File>? _filePickedList) async {
    final data = await _api.sendHomeworkComments(commentData, _filePickedList);
    return data;
  }
}
