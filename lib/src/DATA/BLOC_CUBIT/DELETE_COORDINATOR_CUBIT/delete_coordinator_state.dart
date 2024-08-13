part of 'delete_coordinator_cubit.dart';

abstract class DeleteCoordinatorState extends Equatable {
  const DeleteCoordinatorState();
}

class DeleteCoordinatorInitial extends DeleteCoordinatorState {
  @override
  List<Object> get props => [];
}

class DeleteCoordinatorLoadInProgress extends DeleteCoordinatorState {
  @override
  List<Object> get props => [];
}

class DeleteCoordinatorLoadSuccess extends DeleteCoordinatorState {
  final String result;
  DeleteCoordinatorLoadSuccess(this.result);
  @override
  List<Object> get props => [result];
}

class DeleteCoordinatorLoadFail extends DeleteCoordinatorState {
  final String failReason;
  DeleteCoordinatorLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
