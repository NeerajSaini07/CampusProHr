part of 'get_employee_task_management2_cubit.dart';

abstract class GetEmployeeTaskManagement2State extends Equatable {
  const GetEmployeeTaskManagement2State();
}

class GetEmployeeTaskManagement2Initial
    extends GetEmployeeTaskManagement2State {
  @override
  List<Object> get props => [];
}

class GetEmployeeTaskManagement2LoadInProgress
    extends GetEmployeeTaskManagement2State {
  @override
  List<Object> get props => [];
}

class GetEmployeeTaskManagement2LoadSuccess
    extends GetEmployeeTaskManagement2State {
  final List<GetEmployeeTaskManagementModel> empList;
  GetEmployeeTaskManagement2LoadSuccess(this.empList);
  @override
  List<Object> get props => [empList];
}

class GetEmployeeTaskManagement2LoadFail
    extends GetEmployeeTaskManagement2State {
  final String failReason;
  GetEmployeeTaskManagement2LoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
