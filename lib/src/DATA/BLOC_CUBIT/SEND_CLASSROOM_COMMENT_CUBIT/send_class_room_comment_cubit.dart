import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/activityModel.dart';
import 'package:campus_pro/src/DATA/MODELS/assignTeacherModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/activityRepository.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/assignTeacherRepository.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/sendClassRoomCommentRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'send_class_room_comment_state.dart';

class SendClassRoomCommentCubit extends Cubit<SendClassRoomCommentState> {
  final SendClassRoomCommentRepository _repository;
  SendClassRoomCommentCubit(this._repository)
      : super(SendClassRoomCommentInitial());

  Future<void> sendClassRoomCommentCubitCall(
      Map<String, String> commentData, List<File>? _filePickedList) async {
    if (await isInternetPresent()) {
      try {
        emit(SendClassRoomCommentLoadInProgress());
        final data = await _repository.sendClassRoomComment(
            commentData, _filePickedList);
        emit(SendClassRoomCommentLoadSuccess(data));
      } catch (e) {
        emit(SendClassRoomCommentLoadFail("$e"));
      }
    } else {
      emit(SendClassRoomCommentLoadFail(NO_INTERNET));
    }
  }
}
