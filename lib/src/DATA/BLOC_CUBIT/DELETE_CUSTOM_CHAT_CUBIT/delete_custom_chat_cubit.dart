import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/deleteCustomChatRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'delete_custom_chat_state.dart';

class DeleteCustomChatCubit extends Cubit<DeleteCustomChatState> {
  //Dependency
  final DeleteCustomChatRepository _repository;

  DeleteCustomChatCubit(this._repository) : super(DeleteCustomChatInitial());

  Future<void> deleteCustomChatCubitCall(Map<String, String?> chatData) async {
    if (await isInternetPresent()) {
      try {
        emit(DeleteCustomChatLoadInProgress());
        final data = await _repository.deleteCustomChatData(chatData);
        emit(DeleteCustomChatLoadSuccess(data));
      } catch (e) {
        emit(DeleteCustomChatLoadFail("$e"));
      }
    } else {
      emit(DeleteCustomChatLoadFail(NO_INTERNET));
    }
  }
}