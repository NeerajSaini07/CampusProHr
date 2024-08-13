import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/sendCustomClassRoomCommentRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'send_custom_class_room_comment_state.dart';

class SendCustomClassRoomCommentCubit
    extends Cubit<SendCustomClassRoomCommentState> {
  final SendCustomClassRoomCommentRepository _repository;
  SendCustomClassRoomCommentCubit(this._repository)
      : super(SendCustomClassRoomCommentInitial());

  Future<void> sendCustomClassRoomCommentCubitCall(
      Map<String, String> commentData, List<File>? _filePickedList) async {
    if (await isInternetPresent()) {
      try {
        emit(SendCustomClassRoomCommentLoadInProgress());
        final data = await _repository.sendCustomClassRoomComment(
            commentData, _filePickedList);
        emit(SendCustomClassRoomCommentLoadSuccess(data));
      } catch (e) {
        emit(SendCustomClassRoomCommentLoadFail("$e"));
      }
    } else {
      emit(SendCustomClassRoomCommentLoadFail(NO_INTERNET));
    }
  }
}
