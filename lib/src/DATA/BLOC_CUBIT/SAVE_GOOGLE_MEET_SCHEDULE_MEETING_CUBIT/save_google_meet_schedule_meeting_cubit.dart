import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/saveGoogleMeetScheduleMeetingRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'save_google_meet_schedule_meeting_state.dart';

class SaveGoogleMeetScheduleMeetingCubit extends Cubit<SaveGoogleMeetScheduleMeetingState> {
  final SaveGoogleMeetScheduleMeetingRepository _repository;

  SaveGoogleMeetScheduleMeetingCubit(this._repository) : super(SaveGoogleMeetScheduleMeetingInitial());
  Future<void> saveGoogleMeetScheduleMeetingCubitCall(
      Map<String, String> meetingData) async {
    if (await isInternetPresent()) {
      try {
        emit(SaveGoogleMeetScheduleMeetingLoadInProgress());
        final data = await _repository.scheduleMeeting(meetingData);
        emit(SaveGoogleMeetScheduleMeetingLoadSuccess(data));
      } catch (e) {
        emit(SaveGoogleMeetScheduleMeetingLoadFail("$e"));
      }
    } else {
      emit(SaveGoogleMeetScheduleMeetingLoadFail(NO_INTERNET));
    }
  }
}
