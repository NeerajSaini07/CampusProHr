import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/deleteHomeworkCommentsRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'delete_homework_comment_state.dart';

class DeleteHomeworkCommentCubit extends Cubit<DeleteHomeworkCommentState> {
  final DeleteHomeworkCommentRepository _repository;
  DeleteHomeworkCommentCubit(this._repository)
      : super(DeleteHomeworkCommentInitial());

  Future<void> deleteHomeworkCommentCubitCall(
      Map<String, String?> commentData) async {
    if (await isInternetPresent()) {
      try {
        emit(DeleteHomeworkCommentLoadInProgress());
        final data = await _repository.deleteHomeworkComment(commentData);
        emit(DeleteHomeworkCommentLoadSuccess(data));
      } catch (e) {
        emit(DeleteHomeworkCommentLoadFail("$e"));
      }
    } else {
      emit(DeleteHomeworkCommentLoadFail(NO_INTERNET));
    }
  }
}
