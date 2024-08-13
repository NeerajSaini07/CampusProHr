part of 'assign_period_admin_cubit.dart';

abstract class AssignPeriodAdminState extends Equatable {
  const AssignPeriodAdminState();
}

class AssignPeriodAdminInitial extends AssignPeriodAdminState {
  @override
  List<Object> get props => [];
}

class AssignPeriodAdminLoadInProgress extends AssignPeriodAdminState {
  @override
  List<Object> get props => [];
}

class AssignPeriodAdminLoadSuccess extends AssignPeriodAdminState {
  final String result;
  AssignPeriodAdminLoadSuccess(this.result);
  @override
  List<Object> get props => [result];
}

class AssignPeriodAdminLoadFail extends AssignPeriodAdminState {
  final String failReason;
  AssignPeriodAdminLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
