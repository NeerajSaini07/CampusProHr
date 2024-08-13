part of 'load_employee_groups_cubit.dart';

abstract class LoadEmployeeGroupsState extends Equatable {
  const LoadEmployeeGroupsState();
}

class LoadEmployeeGroupsInitial extends LoadEmployeeGroupsState {
  @override
  List<Object> get props => [];
}

class LoadEmployeeGroupsLoadInProgress extends LoadEmployeeGroupsState {
  @override
  List<Object> get props => [];
}

class LoadEmployeeGroupsLoadSuccess extends LoadEmployeeGroupsState {
  final List<LoadEmployeeGroupsModel> empList;
  LoadEmployeeGroupsLoadSuccess(this.empList);
  @override
  List<Object> get props => [empList];
}

class LoadEmployeeGroupsLoadFail extends LoadEmployeeGroupsState {
  final String failReason;
  LoadEmployeeGroupsLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
