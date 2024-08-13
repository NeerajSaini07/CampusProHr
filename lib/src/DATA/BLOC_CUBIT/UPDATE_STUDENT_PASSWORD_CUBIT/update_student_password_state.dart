part of 'update_student_password_cubit.dart';

abstract class UpdateStudentPasswordState extends Equatable {
  const UpdateStudentPasswordState();
}

class UpdateStudentPasswordInitial extends UpdateStudentPasswordState {
  @override
  List<Object> get props => [];
}

class UpdateStudentPasswordLoadInProgress extends UpdateStudentPasswordState {
  @override
  List<Object> get props => [];
}

class UpdateStudentPasswordLoadSuccess extends UpdateStudentPasswordState {
  final bool status;

  UpdateStudentPasswordLoadSuccess(this.status);
  @override
  List<Object> get props => [status];
}

class UpdateStudentPasswordLoadFail extends UpdateStudentPasswordState {
  final String failReason;

  UpdateStudentPasswordLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
