import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/savePopupMessageRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'save_popup_message_state.dart';

class SavePopupMessageCubit extends Cubit<SavePopupMessageState> {
  final SavePopupMessageRepository _repository;
  SavePopupMessageCubit(this._repository) : super(SavePopupMessageInitial());

  Future<void> savePopupMessageCubitCall(Map<String, String?> request) async {
    if (await isInternetPresent()) {
      try {
        emit(SavePopupMessageLoadInProgress());
        var data = await _repository.savePopupMessage(request);
        emit(SavePopupMessageLoadSuccess(data));
      } catch (e) {
        emit(SavePopupMessageLoadFail('$e'));
      }
    } else {
      emit(SavePopupMessageLoadFail(NO_INTERNET));
    }
  }
}
