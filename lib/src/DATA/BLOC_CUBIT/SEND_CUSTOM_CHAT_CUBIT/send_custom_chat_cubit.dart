import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/sendCustomChatRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'send_custom_chat_state.dart';

class SendCustomChatCubit extends Cubit<SendCustomChatState> {
  //Dependency
  final SendCustomChatRepository _repository;

  SendCustomChatCubit(this._repository) : super(SendCustomChatInitial());

  Future<void> sendCustomChatCubitCall(Map<String, String> commentData, List<File>? _filePickedList) async {
    if (await isInternetPresent()) {
      try {
        emit(SendCustomChatLoadInProgress());
        final data = await _repository.sendCustomChatData(commentData, _filePickedList);
        emit(SendCustomChatLoadSuccess(data));
      } catch (e) {
        emit(SendCustomChatLoadFail("$e"));
      }
    } else {
      emit(SendCustomChatLoadFail(NO_INTERNET));
    }
  }
}
