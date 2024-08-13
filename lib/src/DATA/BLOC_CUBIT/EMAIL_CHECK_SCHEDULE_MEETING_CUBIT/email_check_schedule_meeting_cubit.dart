import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/emailCheckScheduleMeetingRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'email_check_schedule_meeting_state.dart';

class EmailCheckScheduleMeetingCubit
    extends Cubit<EmailCheckScheduleMeetingState> {
  final EmailCheckScheduleMeetingRepository _repository;
  EmailCheckScheduleMeetingCubit(this._repository)
      : super(EmailCheckScheduleMeetingInitial());

  Future<void> emailCheckScheduleMeeting(Map<String, String?> emailData) async {
    if (await isInternetPresent()) {
      try {
        emit(EmailCheckScheduleMeetingLoadInProgress());
        final data = await _repository.emailCheck(emailData);
        emit(EmailCheckScheduleMeetingLoadSuccess(data));
      } catch (e) {
        emit(EmailCheckScheduleMeetingLoadFail("$e"));
      }
    } else {
      emit(EmailCheckScheduleMeetingLoadFail(NO_INTERNET));
    }
  }
}
