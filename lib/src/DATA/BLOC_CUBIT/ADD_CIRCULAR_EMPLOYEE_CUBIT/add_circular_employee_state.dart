part of 'add_circular_employee_cubit.dart';

abstract class AddCircularEmployeeState extends Equatable {
  const AddCircularEmployeeState();
}

class AddCircularEmployeeInitial extends AddCircularEmployeeState {
  @override
  List<Object> get props => [];
}

class AddCircularEmployeeLoadInProgress extends AddCircularEmployeeState {
  @override
  List<Object> get props => [];
}

class AddCircularEmployeeLoadSuccess extends AddCircularEmployeeState {
  final String status;
  AddCircularEmployeeLoadSuccess(this.status);

  @override
  List<Object?> get props => [status];
}

class AddCircularEmployeeLoadFail extends AddCircularEmployeeState {
  final String ReasonFail;

  AddCircularEmployeeLoadFail(this.ReasonFail);
  @override
  List<Object?> get props => [ReasonFail];
}
