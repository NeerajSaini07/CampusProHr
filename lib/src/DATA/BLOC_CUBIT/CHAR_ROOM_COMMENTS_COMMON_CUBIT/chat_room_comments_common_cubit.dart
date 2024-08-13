import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/classRoomCommentsModel.dart';
import 'package:campus_pro/src/DATA/MODELS/customChatModel.dart';
import 'package:campus_pro/src/DATA/MODELS/homeWorkCommentsModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/chatRoomCommentsCommonRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'chat_room_comments_common_state.dart';

class ChatRoomCommentsCommonCubit extends Cubit<ChatRoomCommentsCommonState> {
  final ChatRoomCommentsCommonRepository _repository;
  ChatRoomCommentsCommonCubit(this._repository)
      : super(ChatRoomCommentsCommonInitial());

  Future<void> chatRoomCommentsCommonCubitCall(
      {required Map<String, String?> commentData,
      required String? screenType}) async {
    if (await isInternetPresent()) {
      try {
        emit(ChatRoomCommentsCommonLoadInProgress());
        if (screenType == 'classroom') {
          final data = await _repository.classRoomComments(commentData);
          emit(ChatRoomCommentsCommonLoadSuccess(classroomCommentsList: data));
        } else if (screenType == 'homework') {
          final data = await _repository.homeworkComments(commentData);
          emit(ChatRoomCommentsCommonLoadSuccess(homeworkComments: data));
        } else {
          final data = await _repository.customChatData(commentData);
          emit(ChatRoomCommentsCommonLoadSuccess(customComments: data));
        }
      } catch (e) {
        emit(ChatRoomCommentsCommonLoadFail("$e"));
      }
    } else {
      emit(ChatRoomCommentsCommonLoadFail(NO_INTERNET));
    }
  }
}
