import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/customChatModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/customChatRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'custom_chat_state.dart';

class CustomChatCubit extends Cubit<CustomChatState> {
  //Dependency
  final CustomChatRepository _repository;

  CustomChatCubit(this._repository) : super(CustomChatInitial());

  Future<void> customChatCubitCall(
      {required Map<String, String?> commentData,
      required String? screenType}) async {
    if (await isInternetPresent()) {
      try {
        emit(CustomChatLoadInProgress());
        final data = await _repository.customChatData(commentData);
        emit(CustomChatLoadSuccess(data));
      } catch (e) {
        emit(CustomChatLoadFail("$e"));
      }
    } else {
      emit(CustomChatLoadFail(NO_INTERNET));
    }
  }
}
