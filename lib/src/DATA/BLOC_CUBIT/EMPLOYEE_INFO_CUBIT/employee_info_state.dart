part of 'employee_info_cubit.dart';

abstract class EmployeeInfoState extends Equatable {
  const EmployeeInfoState();
}

class EmployeeInfoInitial extends EmployeeInfoState {
  @override
  List<Object> get props => [];
}

class EmployeeInfoLoadInProgress extends EmployeeInfoState {
  @override
  List<Object> get props => [];
}

class EmployeeInfoLoadSuccess extends EmployeeInfoState {
  final EmployeeInfoModel employeeInfo;

  EmployeeInfoLoadSuccess(this.employeeInfo);
  @override
  List<Object> get props => [employeeInfo];
}

class EmployeeInfoLoadFail extends EmployeeInfoState {
  final String failReason;

  EmployeeInfoLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
