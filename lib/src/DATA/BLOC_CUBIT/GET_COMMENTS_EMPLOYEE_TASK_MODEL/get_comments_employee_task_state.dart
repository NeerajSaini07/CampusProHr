part of 'get_comments_employee_task_cubit.dart';

abstract class GetCommentsEmployeeTaskState extends Equatable {
  const GetCommentsEmployeeTaskState();
}

class GetCommentsEmployeeTaskInitial extends GetCommentsEmployeeTaskState {
  @override
  List<Object> get props => [];
}

class GetCommentsEmployeeLoadInProgress extends GetCommentsEmployeeTaskState {
  @override
  List<Object> get props => [];
}

class GetCommentsEmployeeLoadSuccess extends GetCommentsEmployeeTaskState {
  final List<GetCommentsEmployeeTaskModel> result;
  GetCommentsEmployeeLoadSuccess(this.result);
  @override
  List<Object> get props => [result];
}

class GetCommentsEmployeeLoadFail extends GetCommentsEmployeeTaskState {
  final String failReason;
  GetCommentsEmployeeLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
