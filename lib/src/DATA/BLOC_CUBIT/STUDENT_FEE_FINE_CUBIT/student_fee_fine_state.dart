part of 'student_fee_fine_cubit.dart';

abstract class StudentFeeFineState extends Equatable {
  const StudentFeeFineState();
}

class StudentFeeFineInitial extends StudentFeeFineState {
  @override
  List<Object> get props => [];
}

class StudentFeeFineLoadInProgress extends StudentFeeFineState {
  @override
  List<Object> get props => [];
}

class StudentFeeFineLoadSuccess extends StudentFeeFineState {
  final String studentFine;

  StudentFeeFineLoadSuccess(this.studentFine);
  @override
  List<Object> get props => [];
}

class StudentFeeFineLoadFail extends StudentFeeFineState {
  final String failReason;

  StudentFeeFineLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
