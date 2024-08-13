import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/sendHomeworkCommentsRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';

part 'send_homework_comment_state.dart';

class SendHomeworkCommentCubit extends Cubit<SendHomeworkCommentState> {
  final SendHomeworkCommentRepository _repository;
  SendHomeworkCommentCubit(this._repository)
      : super(SendHomeworkCommentInitial());

  Future<void> sendHomeworkCommentCubitCall(
      Map<String, String> commentData, List<File>? _filePickedList) async {
    if (await isInternetPresent()) {
      try {
        emit(SendHomeworkCommentLoadInProgress());
        final data =
            await _repository.sendHomeworkComment(commentData, _filePickedList);
        emit(SendHomeworkCommentLoadSuccess(data));
      } catch (e) {
        emit(SendHomeworkCommentLoadFail("$e"));
      }
    } else {
      emit(SendHomeworkCommentLoadFail(NO_INTERNET));
    }
  }
}
