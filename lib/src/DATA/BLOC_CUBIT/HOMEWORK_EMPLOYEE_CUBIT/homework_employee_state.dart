part of 'homework_employee_cubit.dart';

abstract class HomeworkEmployeeState extends Equatable {
  const HomeworkEmployeeState();
}

class HomeworkEmployeeInitial extends HomeworkEmployeeState {
  @override
  List<Object> get props => [];
}

class HomeworkEmployeeLoadInProgress extends HomeworkEmployeeState {
  @override
  List<Object> get props => [];
}

class HomeworkEmployeeLoadSuccess extends HomeworkEmployeeState {
  final List<HomeworkEmployeeModel> homeworkEmpData;

  HomeworkEmployeeLoadSuccess(this.homeworkEmpData);
  @override
  List<Object> get props => [homeworkEmpData];
}

class HomeworkEmployeeLoadFail extends HomeworkEmployeeState {
  final String failReason;

  HomeworkEmployeeLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
