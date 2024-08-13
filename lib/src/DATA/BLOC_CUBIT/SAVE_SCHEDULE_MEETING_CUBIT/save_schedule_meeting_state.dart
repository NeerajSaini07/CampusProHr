part of 'save_schedule_meeting_cubit.dart';

abstract class SaveScheduleMeetingState extends Equatable {
  const SaveScheduleMeetingState();
}

class SaveScheduleMeetingInitial extends SaveScheduleMeetingState {
  @override
  List<Object> get props => [];
}

class SaveScheduleMeetingLoadInProgress extends SaveScheduleMeetingState {
  @override
  List<Object> get props => [];
}

class SaveScheduleMeetingLoadSuccess extends SaveScheduleMeetingState {
  final bool status;

  SaveScheduleMeetingLoadSuccess(this.status);
  @override
  List<Object> get props => [status];
}

class SaveScheduleMeetingLoadFail extends SaveScheduleMeetingState {
  final String failReason;

  SaveScheduleMeetingLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
