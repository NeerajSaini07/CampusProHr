part of 'save_zoom_schedule_meeting_cubit.dart';

abstract class SaveZoomScheduleMeetingState extends Equatable {
  const SaveZoomScheduleMeetingState();
}

class SaveZoomScheduleMeetingInitial extends SaveZoomScheduleMeetingState {
  @override
  List<Object> get props => [];
}

class SaveZoomScheduleMeetingLoadInProgress extends SaveZoomScheduleMeetingState {
  @override
  List<Object> get props => [];
}

class SaveZoomScheduleMeetingLoadSuccess extends SaveZoomScheduleMeetingState {
  final bool status;

  SaveZoomScheduleMeetingLoadSuccess(this.status);
  @override
  List<Object> get props => [status];
}

class SaveZoomScheduleMeetingLoadFail extends SaveZoomScheduleMeetingState {
  final String failReason;

  SaveZoomScheduleMeetingLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
