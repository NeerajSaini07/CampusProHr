part of 'delete_student_remark_cubit.dart';

abstract class DeleteStudentRemarkState extends Equatable {
  const DeleteStudentRemarkState();
}

class DeleteStudentRemarkInitial extends DeleteStudentRemarkState {
  @override
  List<Object> get props => [];
}

class DeleteStudentRemarkLoadInProgress extends DeleteStudentRemarkState {
  @override
  List<Object> get props => [];
}

class DeleteStudentRemarkLoadSuccess extends DeleteStudentRemarkState {
  final bool status;

  DeleteStudentRemarkLoadSuccess(this.status);
  @override
  List<Object> get props => [status];
}

class DeleteStudentRemarkLoadFail extends DeleteStudentRemarkState {
  final String failReason;

  DeleteStudentRemarkLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
