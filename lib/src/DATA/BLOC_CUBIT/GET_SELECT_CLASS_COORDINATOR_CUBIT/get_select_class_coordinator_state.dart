part of 'get_select_class_coordinator_cubit.dart';

abstract class GetSelectClassCoordinatorState extends Equatable {
  const GetSelectClassCoordinatorState();
}

class GetSelectClassCoordinatorInitial extends GetSelectClassCoordinatorState {
  @override
  List<Object> get props => [];
}

class GetSelectClassCoordinatorLoadInProgress
    extends GetSelectClassCoordinatorState {
  @override
  List<Object> get props => [];
}

class GetSelectClassCoordinatorLoadSuccess
    extends GetSelectClassCoordinatorState {
  final List<GetSelectClassCoordinatorModel> classList;
  GetSelectClassCoordinatorLoadSuccess(this.classList);
  @override
  List<Object> get props => [classList];
}

class GetSelectClassCoordinatorLoadFail extends GetSelectClassCoordinatorState {
  final String failReason;
  GetSelectClassCoordinatorLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
