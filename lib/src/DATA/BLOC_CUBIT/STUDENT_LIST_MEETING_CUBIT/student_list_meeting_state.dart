part of 'student_list_meeting_cubit.dart';

abstract class StudentListMeetingState extends Equatable {
  const StudentListMeetingState();
}

class StudentListMeetingInitial extends StudentListMeetingState {
  @override
  List<Object> get props => [];
}

class StudentListMeetingLoadInProgress extends StudentListMeetingState {
  @override
  List<Object> get props => [];
}

class StudentListMeetingLoadSuccess extends StudentListMeetingState {
  final List<StudentListMeetingModel> studentList;

  StudentListMeetingLoadSuccess(this.studentList);
  @override
  List<Object> get props => [studentList];
}

class StudentListMeetingLoadFail extends StudentListMeetingState {
  final String? failReason;

  StudentListMeetingLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason!];
}
