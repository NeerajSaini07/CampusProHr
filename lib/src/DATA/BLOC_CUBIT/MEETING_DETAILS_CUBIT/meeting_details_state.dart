part of 'meeting_details_cubit.dart';

abstract class MeetingDetailsState extends Equatable {
  const MeetingDetailsState();
}

class MeetingDetailsInitial extends MeetingDetailsState {
  @override
  List<Object> get props => [];
}

class MeetingDetailsLoadInProgress extends MeetingDetailsState {
  @override
  List<Object> get props => [];
}

class MeetingDetailsLoadSuccess extends MeetingDetailsState {
  final MeetingDetailsModel meetingDetailData;

  MeetingDetailsLoadSuccess(this.meetingDetailData);
  @override
  List<Object> get props => [meetingDetailData];
}

class MeetingDetailsLoadFail extends MeetingDetailsState {
  final String failReason;

  MeetingDetailsLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
