part of 'teachers_list_meeting_cubit.dart';

abstract class TeachersListMeetingState extends Equatable {
  const TeachersListMeetingState();
}

class TeachersListMeetingInitial extends TeachersListMeetingState {
  @override
  List<Object> get props => [];
}

class TeachersListMeetingLoadInProgress extends TeachersListMeetingState {
  @override
  List<Object> get props => [];
}

class TeachersListMeetingLoadSuccess extends TeachersListMeetingState {
  final List<TeachersListMeetingModel> teacherList;

  TeachersListMeetingLoadSuccess(this.teacherList);
  @override
  List<Object> get props => [teacherList];
}

class TeachersListMeetingLoadFail extends TeachersListMeetingState {
  final String failReason;

  TeachersListMeetingLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
