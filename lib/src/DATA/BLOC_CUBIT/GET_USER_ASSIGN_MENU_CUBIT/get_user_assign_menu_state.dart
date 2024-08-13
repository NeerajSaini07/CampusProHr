part of 'get_user_assign_menu_cubit.dart';

abstract class GetUserAssignMenuState extends Equatable {
  const GetUserAssignMenuState();
}

class GetUserAssignMenuInitial extends GetUserAssignMenuState {
  @override
  List<Object> get props => [];
}

class GetUserAssignMenuLoadInProgress extends GetUserAssignMenuState {
  @override
  List<Object> get props => [];
}

class GetUserAssignMenuLoadSuccess extends GetUserAssignMenuState {
  final List<GetUserAssignMenuModel> getAssignList;
  GetUserAssignMenuLoadSuccess(this.getAssignList);
  @override
  List<Object> get props => [getAssignList];
}

class GetUserAssignMenuLoadFail extends GetUserAssignMenuState {
  final String failReason;
  GetUserAssignMenuLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
