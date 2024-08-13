part of 'add_new_employee_cubit.dart';

abstract class AddNewEmployeeState extends Equatable {
  const AddNewEmployeeState();
}

class AddNewEmployeeInitial extends AddNewEmployeeState {
  @override
  List<Object> get props => [];
}

class AddNewEmployeeLoadInProgress extends AddNewEmployeeState {
  @override
  List<Object> get props => [];
}

class AddNewEmployeeLoadSuccess extends AddNewEmployeeState {
  final String result;
  AddNewEmployeeLoadSuccess(this.result);
  @override
  List<Object> get props => [result];
}

class AddNewEmployeeLoadFail extends AddNewEmployeeState {
  final String failReason;
  AddNewEmployeeLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
