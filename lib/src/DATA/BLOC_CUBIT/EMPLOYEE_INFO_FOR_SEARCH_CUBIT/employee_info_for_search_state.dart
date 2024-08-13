part of 'employee_info_for_search_cubit.dart';

abstract class EmployeeInfoForSearchState extends Equatable {
  const EmployeeInfoForSearchState();
}

class EmployeeInfoForSearchInitial extends EmployeeInfoForSearchState {
  @override
  List<Object> get props => [];
}

class EmployeeInfoForSearchLoadInProgress extends EmployeeInfoForSearchState {
  @override
  List<Object> get props => [];
}

class EmployeeInfoForSearchLoadSuccess extends EmployeeInfoForSearchState {
  final EmployeeInfoForSearchModel employeeInfoData;

  EmployeeInfoForSearchLoadSuccess(this.employeeInfoData);
  @override
  List<Object> get props => [employeeInfoData];
}

class EmployeeInfoForSearchLoadFail extends EmployeeInfoForSearchState {
  final String failReason;

  EmployeeInfoForSearchLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
