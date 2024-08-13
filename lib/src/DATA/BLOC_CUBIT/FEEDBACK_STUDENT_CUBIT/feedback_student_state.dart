part of 'feedback_student_cubit.dart';

abstract class FeedbackStudentState extends Equatable {
  const FeedbackStudentState();
}

class FeedbackStudentInitial extends FeedbackStudentState {
  @override
  List<Object> get props => [];
}

class FeedbackStudentLoadInProgress extends FeedbackStudentState {
  @override
  List<Object> get props => [];
}

class FeedbackStudentLoadSuccess extends FeedbackStudentState {
  final bool status;
  FeedbackStudentLoadSuccess(this.status);
  @override
  List<Object> get props => [status];
}

class FeedbackStudentLoadFail extends FeedbackStudentState {
  final String failReason;
  FeedbackStudentLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
