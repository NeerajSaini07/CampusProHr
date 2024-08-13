import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/changeOtpUserLogsRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'change_otp_user_logs_state.dart';

class ChangeOtpUserLogsCubit extends Cubit<ChangeOtpUserLogsState> {
  final ChangeOtpUserLogsRepository _repository;
  ChangeOtpUserLogsCubit(this._repository) : super(ChangeOtpUserLogsInitial());

  Future<void> changeOtpUserLogsCubitCall(Map<String, String?> requestPayload) async {
    if (await isInternetPresent()) {
      try {
        emit(ChangeOtpUserLogsLoadInProgress());
        final data = await _repository.changeOtpUserLogs(requestPayload);
        emit(ChangeOtpUserLogsLoadSuccess(data));
      } catch (e) {
        emit(ChangeOtpUserLogsLoadFail("$e"));
      }
    } else {
      emit(ChangeOtpUserLogsLoadFail(NO_INTERNET));
    }
  }
}

