part of 'online_test_student_cubit.dart';

abstract class OnlineTestStudentState extends Equatable {
  const OnlineTestStudentState();
}

class OnlineTestStudentInitial extends OnlineTestStudentState {
  @override
  List<Object> get props => [];
}

class OnlineTestStudentLoadInProgress extends OnlineTestStudentState {
  @override
  List<Object> get props => [];
}

class OnlineTestStudentLoadSuccess extends OnlineTestStudentState {
  final String onlineTestURL;

  OnlineTestStudentLoadSuccess(this.onlineTestURL);
  @override
  List<Object> get props => [onlineTestURL];
}

class OnlineTestStudentLoadFail extends OnlineTestStudentState {
  final String failReason;

  OnlineTestStudentLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
