part of 'delete_activity_cubit.dart';

abstract class DeleteActivityState extends Equatable {
  const DeleteActivityState();
}

class DeleteActivityInitial extends DeleteActivityState {
  @override
  List<Object> get props => [];
}

class DeleteActivityLoadInProgress extends DeleteActivityState {
  @override
  List<Object> get props => [];
}

class DeleteActivityLoadSuccess extends DeleteActivityState {
  final String result;
  DeleteActivityLoadSuccess(this.result);
  @override
  List<Object> get props => [result];
}

class DeleteActivityLoadFail extends DeleteActivityState {
  final String failReason;
  DeleteActivityLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
