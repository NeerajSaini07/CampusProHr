part of 'assign_class_coordinator_cubit.dart';

abstract class AssignClassCoordinatorState extends Equatable {
  const AssignClassCoordinatorState();
}

class AssignClassCoordinatorInitial extends AssignClassCoordinatorState {
  @override
  List<Object> get props => [];
}

class AssignClassCoordinatorLoadInProgress extends AssignClassCoordinatorState {
  @override
  List<Object> get props => [];
}

class AssignClassCoordinatorLoadSuccess extends AssignClassCoordinatorState {
  final String result;
  AssignClassCoordinatorLoadSuccess(this.result);
  @override
  List<Object> get props => [result];
}

class AssignClassCoordinatorLoadFail extends AssignClassCoordinatorState {
  final String failReason;
  AssignClassCoordinatorLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
