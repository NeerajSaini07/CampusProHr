import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/notifyCounterModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/notifyCounterRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'notify_counter_state.dart';

class NotifyCounterCubit extends Cubit<NotifyCounterState> {
  final NotifyCounterRepository _repository;
  NotifyCounterCubit(this._repository) : super(NotifyCounterInitial());

  Future<void> notificationCubitCall(
      Map<String, String?> requestPayload) async {
    if (await isInternetPresent()) {
      try {
        emit(NotifyCounterLoadInProgress());
        final data = await _repository.notificationData(requestPayload);
        emit(NotifyCounterLoadSuccess(data));
      } catch (e) {
        emit(NotifyCounterLoadFail("$e"));
      }
    } else {
      emit(NotifyCounterLoadFail(NO_INTERNET));
    }
  }
}
