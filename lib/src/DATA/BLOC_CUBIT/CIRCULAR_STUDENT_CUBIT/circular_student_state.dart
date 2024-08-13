part of 'circular_student_cubit.dart';

abstract class CircularStudentState extends Equatable {
  const CircularStudentState();
}

class CircularStudentInitial extends CircularStudentState {
  @override
  List<Object> get props => [];
}

class CircularStudentLoadInProgress extends CircularStudentState {
  @override
  List<Object> get props => [];
}

class CircularStudentLoadSuccess extends CircularStudentState {
  final List<CircularStudentModel> circularStudentList;
  CircularStudentLoadSuccess(this.circularStudentList);
  @override
  List<Object> get props => [];
}

class CircularStudentLoadFail extends CircularStudentState {
  final String failReason;
  CircularStudentLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
