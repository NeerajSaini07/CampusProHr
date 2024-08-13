import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/deleteAlertPopupRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'delete_alert_popup_state.dart';

class DeleteAlertPopupCubit extends Cubit<DeleteAlertPopupState> {
  final DeleteAlertPopupRepository _repository;
  DeleteAlertPopupCubit(this._repository) : super(DeleteAlertPopupInitial());

  Future<void> deleteAlertPopupCubitCall(Map<String, String?> request) async {
    if (await isInternetPresent()) {
      try {
        emit(DeleteAlertPopupLoadInProgress());
        var data = await _repository.deleteAlert(request);
        emit(DeleteAlertPopupLoadSuccess(data));
      } catch (e) {
        emit(DeleteAlertPopupLoadFail('$e'));
      }
    } else {
      emit(DeleteAlertPopupLoadFail(NO_INTERNET));
    }
  }
}
