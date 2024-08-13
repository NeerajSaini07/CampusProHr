part of 'update_plan_employee_cubit.dart';

abstract class UpdateEmployeeState extends Equatable {
  const UpdateEmployeeState();
}

class UpdateEmployeeInitial extends UpdateEmployeeState {
  @override
  List<Object> get props => [];
}

class UpdateEmployeeLoadInProgress extends UpdateEmployeeState {
  @override
  List<Object?> get props => [];
}

class UpdateEmployeeLoadSuccess extends UpdateEmployeeState {
  final List<UpdatePlanEmployeeModel> PlanList;
  UpdateEmployeeLoadSuccess(this.PlanList);
  @override
  List<Object?> get props => [PlanList];
}

class UpdateEmployeeLoadFail extends UpdateEmployeeState {
  final String failReason;
  UpdateEmployeeLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
