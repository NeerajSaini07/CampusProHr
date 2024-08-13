part of 'get_coordinator_list_cubit.dart';

abstract class GetCoordinatorListState extends Equatable {
  const GetCoordinatorListState();
}

class GetCoordinatorListInitial extends GetCoordinatorListState {
  @override
  List<Object> get props => [];
}

class GetCoordinatorListLoadInProgress extends GetCoordinatorListState {
  @override
  List<Object> get props => [];
}

class GetCoordinatorListLoadSuccess extends GetCoordinatorListState {
  final List<GetCoordinatorListModel> coordinatorList;
  GetCoordinatorListLoadSuccess(this.coordinatorList);
  @override
  List<Object> get props => [coordinatorList];
}

class GetCoordinatorListLoadFail extends GetCoordinatorListState {
  final String failReason;
  GetCoordinatorListLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
