part of 'get_employee_task_status_cubit.dart';

abstract class GetEmployeeTaskStatusState extends Equatable {
  const GetEmployeeTaskStatusState();
}

class GetEmployeeTaskStatusInitial extends GetEmployeeTaskStatusState {
  @override
  List<Object> get props => [];
}

class GetEmployeeTaskStatusLoadInProgress extends GetEmployeeTaskStatusState {
  @override
  List<Object> get props => [];
}

class GetEmployeeTaskStatusLoadSuccess extends GetEmployeeTaskStatusState {
  final List<GetEmployeeTaskManagementModel> empList;
  GetEmployeeTaskStatusLoadSuccess(this.empList);
  @override
  List<Object> get props => [empList];
}

class GetEmployeeTaskStatusLoadFail extends GetEmployeeTaskStatusState {
  final String failReason;
  GetEmployeeTaskStatusLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
