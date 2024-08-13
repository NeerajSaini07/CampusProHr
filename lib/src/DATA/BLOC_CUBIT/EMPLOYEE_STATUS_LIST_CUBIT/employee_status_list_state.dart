part of 'employee_status_list_cubit.dart';

abstract class EmployeeStatusListState extends Equatable {
  const EmployeeStatusListState();
}

class EmployeeStatusListInitial extends EmployeeStatusListState {
  @override
  List<Object> get props => [];
}

class EmployeeStatusListLoadInProgress extends EmployeeStatusListState {
  @override
  List<Object> get props => [];
}

class EmployeeStatusListLoadSuccess extends EmployeeStatusListState {
  final EmployeeStatusListModel employeeStatusList;

  EmployeeStatusListLoadSuccess(this.employeeStatusList);
  @override
  List<Object> get props => [employeeStatusList];
}

class EmployeeStatusListLoadFail extends EmployeeStatusListState {
  final String failReason;

  EmployeeStatusListLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
