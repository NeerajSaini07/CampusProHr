part of 'delete_user_employee_status_cubit.dart';

abstract class DeleteUserEmployeeStatusState extends Equatable {
  const DeleteUserEmployeeStatusState();
}

class DeleteUserEmployeeStatusInitial extends DeleteUserEmployeeStatusState {
  @override
  List<Object> get props => [];
}

class DeleteUserEmployeeStatusLoadInProgress
    extends DeleteUserEmployeeStatusState {
  @override
  List<Object> get props => [];
}

class DeleteUserEmployeeStatusLoadSuccess
    extends DeleteUserEmployeeStatusState {
  final bool status;

  DeleteUserEmployeeStatusLoadSuccess(this.status);
  @override
  List<Object> get props => [status];
}

class DeleteUserEmployeeStatusLoadFail extends DeleteUserEmployeeStatusState {
  final String failReason;

  DeleteUserEmployeeStatusLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
