part of 'update_assign_menu_cubit.dart';

abstract class UpdateAssignMenuState extends Equatable {
  const UpdateAssignMenuState();
}

class UpdateAssignMenuInitial extends UpdateAssignMenuState {
  @override
  List<Object> get props => [];
}

class UpdateAssignMenuLoadInProgress extends UpdateAssignMenuState {
  @override
  List<Object> get props => [];
}

class UpdateAssignMenuLoadSuccess extends UpdateAssignMenuState {
  final String result;
  UpdateAssignMenuLoadSuccess(this.result);
  @override
  List<Object> get props => [result];
}

class UpdateAssignMenuLoadFail extends UpdateAssignMenuState {
  final String error;
  UpdateAssignMenuLoadFail(this.error);
  @override
  List<Object> get props => [error];
}
