part of 'get_employee_online_cred_cubit.dart';

abstract class GetEmployeeOnlineCredState extends Equatable {
  const GetEmployeeOnlineCredState();
}

class GetEmployeeOnlineCredInitial extends GetEmployeeOnlineCredState {
  @override
  List<Object> get props => [];
}

class GetEmployeeOnlineCredLoadInProgress extends GetEmployeeOnlineCredState {
  @override
  List<Object> get props => [];
}

class GetEmployeeOnlineCredLoadSuccess extends GetEmployeeOnlineCredState {
  final dynamic result;
  GetEmployeeOnlineCredLoadSuccess(this.result);
  @override
  List<Object> get props => [result];
}

class GetEmployeeOnlineCredLoadFail extends GetEmployeeOnlineCredState {
  final String failReason;
  GetEmployeeOnlineCredLoadFail(this.failReason);

  @override
  List<Object> get props => [failReason];
}
