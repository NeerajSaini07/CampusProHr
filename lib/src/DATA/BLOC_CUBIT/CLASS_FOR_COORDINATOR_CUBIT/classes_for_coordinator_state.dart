part of 'classes_for_coordinator_cubit.dart';

abstract class ClassesForCoordinatorState extends Equatable {
  const ClassesForCoordinatorState();
}

class ClassesForCoordinatorInitial extends ClassesForCoordinatorState {
  @override
  List<Object> get props => [];
}

class ClassesForCoordinatorLoadInProgress extends ClassesForCoordinatorState {
  @override
  List<Object> get props => [];
}

class ClassesForCoordinatorLoadSuccess extends ClassesForCoordinatorState {
  final List<ClassesForCoordinatorModel> classList;
  ClassesForCoordinatorLoadSuccess(this.classList);
  @override
  List<Object> get props => [classList];
}

class ClassesForCoordinatorLoadFail extends ClassesForCoordinatorState {
  final String failReason;
  ClassesForCoordinatorLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
