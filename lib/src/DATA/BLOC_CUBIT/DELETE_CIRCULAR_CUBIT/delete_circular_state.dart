part of 'delete_circular_cubit.dart';

abstract class DeleteCircularState extends Equatable {
  const DeleteCircularState();
}

class DeleteCircularInitial extends DeleteCircularState {
  @override
  List<Object> get props => [];
}

class DeleteCircularLoadInProgress extends DeleteCircularState {
  @override
  List<Object> get props => [];
}

class DeleteCircularLoadSuccess extends DeleteCircularState {
  final bool status;

  DeleteCircularLoadSuccess(this.status);
  @override
  List<Object> get props => [status];
}

class DeleteCircularLoadFail extends DeleteCircularState {
  final String failReason;

  DeleteCircularLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
