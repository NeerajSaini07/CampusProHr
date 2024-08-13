part of 'save_student_remark_cubit.dart';

abstract class SaveStudentRemarkState extends Equatable {
  const SaveStudentRemarkState();
}

class SaveStudentRemarkInitial extends SaveStudentRemarkState {
  @override
  List<Object> get props => [];
}

class SaveStudentRemarkLoadInProgress extends SaveStudentRemarkState {
  @override
  List<Object> get props => [];
}

class SaveStudentRemarkLoadSuccess extends SaveStudentRemarkState {
  final bool status;

  SaveStudentRemarkLoadSuccess(this.status);
  @override
  List<Object> get props => [status];
}

class SaveStudentRemarkLoadFail extends SaveStudentRemarkState {
  final String failReason;

  SaveStudentRemarkLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
