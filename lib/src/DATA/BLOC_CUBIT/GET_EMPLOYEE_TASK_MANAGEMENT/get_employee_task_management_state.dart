part of 'get_employee_task_management_cubit.dart';

abstract class GetEmployeeTaskManagementState extends Equatable {
  const GetEmployeeTaskManagementState();
}

class GetEmployeeTaskManagementInitial extends GetEmployeeTaskManagementState {
  @override
  List<Object> get props => [];
}

class GetEmployeeTaskManagementLoadInProgress
    extends GetEmployeeTaskManagementState {
  @override
  List<Object> get props => [];
}

class GetEmployeeTaskManagementLoadSuccess
    extends GetEmployeeTaskManagementState {
  final List<GetEmployeeTaskManagementModel> empList;
  GetEmployeeTaskManagementLoadSuccess(this.empList);
  @override
  List<Object> get props => [empList];
}

class GetEmployeeTaskManagementLoadFail extends GetEmployeeTaskManagementState {
  final String failReason;
  GetEmployeeTaskManagementLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
