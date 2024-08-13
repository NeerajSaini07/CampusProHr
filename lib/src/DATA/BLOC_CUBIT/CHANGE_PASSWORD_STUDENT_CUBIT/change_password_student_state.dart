part of 'change_password_student_cubit.dart';

abstract class ChangePasswordStudentState extends Equatable {
  const ChangePasswordStudentState();
}

class ChangePasswordStudentInitial extends ChangePasswordStudentState {
  @override
  List<Object> get props => [];
}

class ChangePasswordStudentLoadInProgress extends ChangePasswordStudentState {
  @override
  List<Object> get props => [];
}

class ChangePasswordStudentLoadSuccess extends ChangePasswordStudentState {
  final String status;
  ChangePasswordStudentLoadSuccess(this.status);
  @override
  List<Object> get props => [status];
}

class ChangePasswordStudentLoadFail extends ChangePasswordStudentState {
  final String failReason;
  ChangePasswordStudentLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
