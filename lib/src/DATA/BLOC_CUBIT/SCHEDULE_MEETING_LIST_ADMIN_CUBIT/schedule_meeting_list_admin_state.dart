part of 'schedule_meeting_list_admin_cubit.dart';

abstract class ScheduleMeetingListAdminState extends Equatable {
  const ScheduleMeetingListAdminState();
}

class ScheduleMeetingListAdminInitial
    extends ScheduleMeetingListAdminState {
  @override
  List<Object> get props => [];
}

class ScheduleMeetingListAdminLoadInProgress
    extends ScheduleMeetingListAdminState {
  @override
  List<Object> get props => [];
}

class ScheduleMeetingListAdminLoadSuccess
    extends ScheduleMeetingListAdminState {
  final List<ScheduleMeetingListAdminModel> meetingList;

  ScheduleMeetingListAdminLoadSuccess(this.meetingList);
  @override
  List<Object> get props => [meetingList];
}

class ScheduleMeetingListAdminLoadFail
    extends ScheduleMeetingListAdminState {
  final String? failReason;

  ScheduleMeetingListAdminLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason!];
}
