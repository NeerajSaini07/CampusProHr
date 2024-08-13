part of 'meeting_status_list_admin_cubit.dart';

abstract class MeetingStatusListAdminState extends Equatable {
  const MeetingStatusListAdminState();
}

class MeetingStatusListAdminInitial extends MeetingStatusListAdminState {
  @override
  List<Object> get props => [];
}

class MeetingStatusListAdminLoadInProgress extends MeetingStatusListAdminState {
  @override
  List<Object> get props => [];
}

class MeetingStatusListAdminLoadSuccess extends MeetingStatusListAdminState {
  final List<MeetingStatusListAdminModel> statusList;

  MeetingStatusListAdminLoadSuccess(this.statusList);
  @override
  List<Object> get props => [statusList];
}

class MeetingStatusListAdminLoadFail extends MeetingStatusListAdminState {
  final String failReason;

  MeetingStatusListAdminLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
