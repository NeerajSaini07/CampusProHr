part of 'save_google_meet_schedule_meeting_admin_cubit.dart';

abstract class SaveGoogleMeetScheduleMeetingAdminState extends Equatable {
  const SaveGoogleMeetScheduleMeetingAdminState();
}

class SaveGoogleMeetScheduleMeetingAdminInitial
    extends SaveGoogleMeetScheduleMeetingAdminState {
  @override
  List<Object> get props => [];
}

class SaveGoogleMeetScheduleMeetingAdminLoadInProgress
    extends SaveGoogleMeetScheduleMeetingAdminState {
  @override
  List<Object> get props => [];
}

class SaveGoogleMeetScheduleMeetingAdminLoadSuccess
    extends SaveGoogleMeetScheduleMeetingAdminState {
      final bool status;

  SaveGoogleMeetScheduleMeetingAdminLoadSuccess(this.status);
  @override
  List<Object> get props => [status];
}

class SaveGoogleMeetScheduleMeetingAdminLoadFail
    extends SaveGoogleMeetScheduleMeetingAdminState {
      final String failReason;

  SaveGoogleMeetScheduleMeetingAdminLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
