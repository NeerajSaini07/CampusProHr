part of 'classroom_employee_cubit.dart';

abstract class ClassroomEmployeeState extends Equatable {
  const ClassroomEmployeeState();
}

class ClassroomEmployeeInitial extends ClassroomEmployeeState {
  @override
  List<Object> get props => [];
}

class ClassroomEmployeeLoadInProgress extends ClassroomEmployeeState {
  @override
  List<Object> get props => [];
}

class ClassroomEmployeeLoadSuccess extends ClassroomEmployeeState {
  final List<ClassroomEmployeeModel> classroomEmpData;

  ClassroomEmployeeLoadSuccess(this.classroomEmpData);
  @override
  List<Object> get props => [classroomEmpData];
}

class ClassroomEmployeeLoadFail extends ClassroomEmployeeState {
  final String failReason;

  ClassroomEmployeeLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
