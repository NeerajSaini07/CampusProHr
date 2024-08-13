part of 'save_zoom_schedule_meeting_admin_cubit.dart';

abstract class SaveZoomScheduleMeetingAdminState extends Equatable {
  const SaveZoomScheduleMeetingAdminState();
}

class SaveZoomScheduleMeetingAdminInitial extends SaveZoomScheduleMeetingAdminState {
  @override
  List<Object> get props => [];
}

class SaveZoomScheduleMeetingAdminLoadInProgress extends SaveZoomScheduleMeetingAdminState {
  @override
  List<Object> get props => [];
}

class SaveZoomScheduleMeetingAdminLoadSuccess extends SaveZoomScheduleMeetingAdminState {
  final bool status;

  SaveZoomScheduleMeetingAdminLoadSuccess(this.status);
  @override
  List<Object> get props => [status];
}

class SaveZoomScheduleMeetingAdminLoadFail extends SaveZoomScheduleMeetingAdminState {
  final String failReason;

  SaveZoomScheduleMeetingAdminLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
