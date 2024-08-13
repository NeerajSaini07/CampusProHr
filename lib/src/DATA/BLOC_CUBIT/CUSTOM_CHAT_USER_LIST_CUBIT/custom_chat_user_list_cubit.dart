import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/customChatUserListModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/customChatUserListRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'custom_chat_user_list_state.dart';

class CustomChatUserListCubit extends Cubit<CustomChatUserListState> {
  //Dependency
  final CustomChatUserListRepository _repository;

  CustomChatUserListCubit(this._repository)
      : super(CustomChatUserListInitial());

  Future<void> customChatUserListCubitCall(Map<String, String?> chatData) async {
    if (await isInternetPresent()) {
      try {
        emit(CustomChatUserListLoadInProgress());
        final data = await _repository.customChatData(chatData);
        emit(CustomChatUserListLoadSuccess(data));
      } catch (e) {
        emit(CustomChatUserListLoadFail("$e"));
      }
    } else {
      emit(CustomChatUserListLoadFail(NO_INTERNET));
    }
  }
}
