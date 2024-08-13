part of 'meeting_details_admin_cubit.dart';

abstract class MeetingDetailsAdminState extends Equatable {
  const MeetingDetailsAdminState();
}

class MeetingDetailsAdminInitial extends MeetingDetailsAdminState {
  @override
  List<Object> get props => [];
}

class MeetingDetailsAdminLoadInProgress extends MeetingDetailsAdminState {
  @override
  List<Object> get props => [];
}

class MeetingDetailsAdminLoadSuccess extends MeetingDetailsAdminState {
  final MeetingDetailsAdminModel meetingDetailData;

  MeetingDetailsAdminLoadSuccess(this.meetingDetailData);
  @override
  List<Object> get props => [meetingDetailData];
}

class MeetingDetailsAdminLoadFail extends MeetingDetailsAdminState {
  final String failReason;

  MeetingDetailsAdminLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
