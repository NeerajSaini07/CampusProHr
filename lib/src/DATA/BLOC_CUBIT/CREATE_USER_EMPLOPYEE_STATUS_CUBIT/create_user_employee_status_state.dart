part of 'create_user_employee_status_cubit.dart';

abstract class CreateUserEmployeeStatusState extends Equatable {
  const CreateUserEmployeeStatusState();
}

class CreateUserEmployeeStatusInitial extends CreateUserEmployeeStatusState {
  @override
  List<Object> get props => [];
}

class CreateUserEmployeeStatusLoadInProgress
    extends CreateUserEmployeeStatusState {
  @override
  List<Object> get props => [];
}

class CreateUserEmployeeStatusLoadSuccess
    extends CreateUserEmployeeStatusState {
      final bool status;

  CreateUserEmployeeStatusLoadSuccess(this.status);
  @override
  List<Object> get props => [status];
}

class CreateUserEmployeeStatusLoadFail extends CreateUserEmployeeStatusState {
  final String failReason;

  CreateUserEmployeeStatusLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
