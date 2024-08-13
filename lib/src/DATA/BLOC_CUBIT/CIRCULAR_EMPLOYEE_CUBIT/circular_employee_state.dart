part of 'circular_employee_cubit.dart';

abstract class CircularEmployeeState extends Equatable {
  const CircularEmployeeState();
}

class CircularEmployeeInitial extends CircularEmployeeState {
  @override
  List<Object> get props => [];
}

class CircularEmployeeLoadInProgress extends CircularEmployeeState {
  @override
  List<Object> get props => [];
}

class CircularEmployeeLoadSuccess extends CircularEmployeeState {
  final List<CircularEmployeeModel> circularList;

  CircularEmployeeLoadSuccess(this.circularList);
  @override
  List<Object> get props => [circularList];
}

class CircularEmployeeLoadFail extends CircularEmployeeState {
  final String failReason;

  CircularEmployeeLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
