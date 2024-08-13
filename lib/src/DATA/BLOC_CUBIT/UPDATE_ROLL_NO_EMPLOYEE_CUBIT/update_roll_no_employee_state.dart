part of 'update_roll_no_employee_cubit.dart';

abstract class UpdateRollNoEmployeeState extends Equatable {
  const UpdateRollNoEmployeeState();
}

class UpdateRollNoEmployeeInitial extends UpdateRollNoEmployeeState {
  @override
  List<Object> get props => [];
}

class UpdateRollNoEmployeeLoadInProgress extends UpdateRollNoEmployeeState {
  @override
  List<Object> get props => [];
}

class UpdateRollNoEmployeeLoadSuccess extends UpdateRollNoEmployeeState {
  final String result;
  UpdateRollNoEmployeeLoadSuccess(this.result);
  @override
  List<Object> get props => [result];
}

class UpdateRollNoEmployeeLoadFail extends UpdateRollNoEmployeeState {
  final String failReason;
  UpdateRollNoEmployeeLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
