part of 'email_check_schedule_meeting_cubit.dart';

abstract class EmailCheckScheduleMeetingState extends Equatable {
  const EmailCheckScheduleMeetingState();
}

class EmailCheckScheduleMeetingInitial extends EmailCheckScheduleMeetingState {
  @override
  List<Object> get props => [];
}

class EmailCheckScheduleMeetingLoadInProgress
    extends EmailCheckScheduleMeetingState {
  @override
  List<Object> get props => [];
}

class EmailCheckScheduleMeetingLoadSuccess
    extends EmailCheckScheduleMeetingState {
  final String? emailId;

  EmailCheckScheduleMeetingLoadSuccess(this.emailId);
  @override
  List<Object> get props => [emailId!];
}

class EmailCheckScheduleMeetingLoadFail extends EmailCheckScheduleMeetingState {
  final String? failReason;

  EmailCheckScheduleMeetingLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason!];
}
