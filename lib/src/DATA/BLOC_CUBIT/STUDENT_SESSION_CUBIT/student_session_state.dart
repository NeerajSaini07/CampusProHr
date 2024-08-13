part of 'student_session_cubit.dart';

abstract class StudentSessionState extends Equatable {
  const StudentSessionState();
}

class StudentSessionInitial extends StudentSessionState {
  @override
  List<Object> get props => [];
}

class StudentSessionLoadInProgress extends StudentSessionState {
  @override
  List<Object> get props => [];
}

class StudentSessionLoadSuccess extends StudentSessionState {
  final List<StudentSessionModel> sessionData;

  StudentSessionLoadSuccess(this.sessionData);
  @override
  List<Object> get props => [sessionData];
}

class StudentSessionLoadFail extends StudentSessionState {
  final String failReason;

  StudentSessionLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
