part of 'create_user_student_status_cubit.dart';

abstract class CreateUserStudentStatusState extends Equatable {
  const CreateUserStudentStatusState();
}

class CreateUserStudentStatusInitial extends CreateUserStudentStatusState {
  @override
  List<Object> get props => [];
}

class CreateUserStudentStatusLoadInProgress
    extends CreateUserStudentStatusState {
  @override
  List<Object> get props => [];
}

class CreateUserStudentStatusLoadSuccess extends CreateUserStudentStatusState {
  final bool status;

  CreateUserStudentStatusLoadSuccess(this.status);
  @override
  List<Object> get props => [status];
}

class CreateUserStudentStatusLoadFail extends CreateUserStudentStatusState {
  final String failReason;

  CreateUserStudentStatusLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
