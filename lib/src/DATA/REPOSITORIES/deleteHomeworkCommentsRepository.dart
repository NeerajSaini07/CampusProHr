import 'package:campus_pro/src/DATA/API_SERVICES/assignTeacherApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/deleteHomeworkCommentsApi.dart';
import 'package:campus_pro/src/DATA/MODELS/assignTeacherModel.dart';

abstract class DeleteHomeworkCommentRepositoryAbs {
  Future<bool> deleteHomeworkComment(Map<String, String> commentData);
}

class DeleteHomeworkCommentRepository
    extends DeleteHomeworkCommentRepositoryAbs {
  final DeleteHomeworkCommentApi _api;
  DeleteHomeworkCommentRepository(this._api);
  @override
  Future<bool> deleteHomeworkComment(Map<String, String?> commentData) async {
    final data = await _api.deleteHomeworkComments(commentData);
    return data;
  }
}
