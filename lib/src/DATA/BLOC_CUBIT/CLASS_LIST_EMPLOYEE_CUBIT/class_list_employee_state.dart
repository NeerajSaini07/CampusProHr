part of 'class_list_employee_cubit.dart';

abstract class ClassListEmployeeState extends Equatable {
  const ClassListEmployeeState();
}

class ClassListEmployeeInitial extends ClassListEmployeeState {
  @override
  List<Object> get props => [];
}

class ClassListEmployeeLoadInProgress extends ClassListEmployeeState {
  @override
  List<Object> get props => [];
}

class ClassListEmployeeLoadSuccess extends ClassListEmployeeState {
  final List<ClassListEmployeeModel> classList;
  ClassListEmployeeLoadSuccess(this.classList);
  @override
  List<Object> get props => [classList];
}

class ClassListEmployeeLoadFail extends ClassListEmployeeState {
  final String failReason;
  ClassListEmployeeLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
