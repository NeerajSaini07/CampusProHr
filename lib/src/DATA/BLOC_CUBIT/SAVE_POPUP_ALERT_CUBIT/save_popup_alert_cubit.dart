import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/savePopupAlertRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'save_popup_alert_state.dart';

class SavePopupAlertCubit extends Cubit<SavePopupAlertState> {
  final SavePopupAlertRepository _repository;
  SavePopupAlertCubit(this._repository) : super(SavePopupAlertInitial());

  Future<void> savePopupAlertCubitCall(Map<String, String?> request) async {
    if (await isInternetPresent()) {
      try {
        emit(SavePopupAlertLoadInProgress());
        var data = await _repository.savePopupAlert(request);
        emit(SavePopupAlertLoadSuccess(data));
      } catch (e) {
        emit(SavePopupAlertLoadFail('$e'));
      }
    } else {
      emit(SavePopupAlertLoadFail(NO_INTERNET));
    }
  }
}
