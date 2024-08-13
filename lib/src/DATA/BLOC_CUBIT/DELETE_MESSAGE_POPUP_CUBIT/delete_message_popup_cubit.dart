import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/PAYMENT_GATEWAY_API/techProcessHashApi.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/deleteMessagePopupRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'delete_message_popup_state.dart';

class DeleteMessagePopupCubit extends Cubit<DeleteMessagePopupState> {
  final DeleteMessagePopupRepository repository;
  DeleteMessagePopupCubit(this.repository) : super(DeleteMessagePopupInitial());

  Future<void> deleteMessagePopupCubitCall(Map<String, String?> request) async {
    if (await isInternetPresent()) {
      try {
        emit(DeleteMessagePopupLoadInProgress());
        var data = await repository.deleteMessage(request);
        emit(DeleteMessagePopupLoadSuccess(data));
      } catch (e) {
        emit(DeleteMessagePopupLoadFail('$e'));
      }
    } else {
      emit(DeleteMessagePopupLoadFail(NO_INTERNET));
    }
  }
}
