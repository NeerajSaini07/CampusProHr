part of 'get_tesk_data_employee_cubit.dart';

abstract class GetTeskDataEmployeeState extends Equatable {
  const GetTeskDataEmployeeState();
}

class GetTeskDataEmployeeInitial extends GetTeskDataEmployeeState {
  @override
  List<Object> get props => [];
}

class GetTeskDataEmployeeLoadInProgress extends GetTeskDataEmployeeState {
  @override
  List<Object> get props => [];
}

class GetTeskDataEmployeeLoadSuccess extends GetTeskDataEmployeeState {
  final List<GetTaskDataEmployeeModel> empList;
  GetTeskDataEmployeeLoadSuccess(this.empList);
  @override
  List<Object> get props => [empList];
}

class GetTeskDataEmployeeLoadFail extends GetTeskDataEmployeeState {
  final String failReason;
  GetTeskDataEmployeeLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
