part of 'student_history_employee_cubit.dart';

abstract class StudentHistoryEmployeeState extends Equatable {
  const StudentHistoryEmployeeState();
}

class StudentHistoryEmployeeInitial extends StudentHistoryEmployeeState {
  @override
  List<Object> get props => [];
}

class StudentHistoryEmployeeLoadInProgress extends StudentHistoryEmployeeState {
  @override
  List<Object> get props => [];
}

class StudentHistoryEmployeeLoadSuccess extends StudentHistoryEmployeeState {
  final List<StudentLeaveEmployeeHistoryModel> LeaveList;
  StudentHistoryEmployeeLoadSuccess(this.LeaveList);
  @override
  List<Object> get props => [LeaveList];
}

class StudentHistoryEmployeeLoadFail extends StudentHistoryEmployeeState {
  final String failReason;
  StudentHistoryEmployeeLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
