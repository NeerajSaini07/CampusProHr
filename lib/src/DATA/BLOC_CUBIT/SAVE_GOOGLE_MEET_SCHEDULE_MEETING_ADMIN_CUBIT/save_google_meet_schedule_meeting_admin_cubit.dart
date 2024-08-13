import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/saveGoogleMeetScheduleMeetingAdminRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'save_google_meet_schedule_meeting_admin_state.dart';

class SaveGoogleMeetScheduleMeetingAdminCubit extends Cubit<SaveGoogleMeetScheduleMeetingAdminState> {
  final SaveGoogleMeetScheduleMeetingAdminRepository _repository;

  SaveGoogleMeetScheduleMeetingAdminCubit(this._repository) : super(SaveGoogleMeetScheduleMeetingAdminInitial());
  Future<void> saveGoogleMeetScheduleMeetingAdminCubitCall(
      Map<String, String?> meetingData) async {
    if (await isInternetPresent()) {
      try {
        emit(SaveGoogleMeetScheduleMeetingAdminLoadInProgress());
        final data = await _repository.scheduleMeetingAdmin(meetingData);
        emit(SaveGoogleMeetScheduleMeetingAdminLoadSuccess(data));
      } catch (e) {
        emit(SaveGoogleMeetScheduleMeetingAdminLoadFail("$e"));
      }
    } else {
      emit(SaveGoogleMeetScheduleMeetingAdminLoadFail(NO_INTERNET));
    }
  }
}
