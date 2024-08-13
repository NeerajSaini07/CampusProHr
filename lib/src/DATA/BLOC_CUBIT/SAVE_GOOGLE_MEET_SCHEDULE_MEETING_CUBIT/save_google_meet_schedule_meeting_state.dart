part of 'save_google_meet_schedule_meeting_cubit.dart';

abstract class SaveGoogleMeetScheduleMeetingState extends Equatable {
  const SaveGoogleMeetScheduleMeetingState();
}

class SaveGoogleMeetScheduleMeetingInitial
    extends SaveGoogleMeetScheduleMeetingState {
  @override
  List<Object> get props => [];
}

class SaveGoogleMeetScheduleMeetingLoadInProgress
    extends SaveGoogleMeetScheduleMeetingState {
  @override
  List<Object> get props => [];
}

class SaveGoogleMeetScheduleMeetingLoadSuccess
    extends SaveGoogleMeetScheduleMeetingState {
      final bool status;

  SaveGoogleMeetScheduleMeetingLoadSuccess(this.status);
  @override
  List<Object> get props => [status];
}

class SaveGoogleMeetScheduleMeetingLoadFail
    extends SaveGoogleMeetScheduleMeetingState {
      final String failReason;

  SaveGoogleMeetScheduleMeetingLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
