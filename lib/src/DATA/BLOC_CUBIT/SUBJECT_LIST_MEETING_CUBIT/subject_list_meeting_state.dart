part of 'subject_list_meeting_cubit.dart';

abstract class SubjectListMeetingState extends Equatable {
  const SubjectListMeetingState();
}

class SubjectListMeetingInitial extends SubjectListMeetingState {
  @override
  List<Object> get props => [];
}

class SubjectListMeetingLoadInProgress extends SubjectListMeetingState {
  @override
  List<Object> get props => [];
}

class SubjectListMeetingLoadSuccess extends SubjectListMeetingState {
  final List<SubjectListMeetingModel> subjectList;

  SubjectListMeetingLoadSuccess(this.subjectList);
  @override
  List<Object> get props => [subjectList];
}

class SubjectListMeetingLoadFail extends SubjectListMeetingState {
  final String? failReason;

  SubjectListMeetingLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason!];
}
