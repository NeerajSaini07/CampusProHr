part of 'add_plan_employee_cubit.dart';

abstract class AddPlanEmployeeState extends Equatable {
  const AddPlanEmployeeState();
}

class AddPlanEmployeeInitial extends AddPlanEmployeeState {
  @override
  List<Object> get props => [];
}

class AddPlanEmployeeLoadInProgress extends AddPlanEmployeeState {
  @override
  List<Object> get props => [];
}

class AddPlanEmployeeLoadSuccess extends AddPlanEmployeeState {
  final String status;
  AddPlanEmployeeLoadSuccess(this.status);

  @override
  List<Object?> get props => [status];
}

class AddPlanEmployeeLoadFail extends AddPlanEmployeeState {
  final String failReason;

  AddPlanEmployeeLoadFail(this.failReason);
  @override
  List<Object?> get props => [failReason];
}
