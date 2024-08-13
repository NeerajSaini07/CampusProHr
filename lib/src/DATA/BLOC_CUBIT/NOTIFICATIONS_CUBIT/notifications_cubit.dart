import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/notificationsModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/notificationsRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  final NotificationsRepository _repository;
  NotificationsCubit(this._repository) : super(NotificationInitial());

  Future<void> notificationCubitCall(
      Map<String, String?> requestPayload) async {
    if (await isInternetPresent()) {
      try {
        emit(NotificationsLoadInProgress());
        final data = await _repository.notificationData(requestPayload);
        emit(NotificationsLoadSuccess(data));
      } catch (e) {
        emit(NotificationsLoadFail("$e"));
      }
    } else {
      emit(NotificationsLoadFail(NO_INTERNET));
    }
  }
}
