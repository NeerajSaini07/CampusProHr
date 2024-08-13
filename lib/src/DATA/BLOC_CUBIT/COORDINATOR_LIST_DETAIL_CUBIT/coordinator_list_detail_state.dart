part of 'coordinator_list_detail_cubit.dart';

abstract class CoordinatorListDetailState extends Equatable {
  const CoordinatorListDetailState();
}

class CoordinatorListDetailInitial extends CoordinatorListDetailState {
  @override
  List<Object> get props => [];
}

class CoordinatorListDetailLoadInProgress extends CoordinatorListDetailState {
  @override
  List<Object> get props => [];
}

class CoordinatorListDetailLoadSuccess extends CoordinatorListDetailState {
  final List<CoordinatorListDetailModel> coordinatorList;
  CoordinatorListDetailLoadSuccess(this.coordinatorList);
  @override
  List<Object> get props => [coordinatorList];
}

class CoordinatorListDetailLoadFail extends CoordinatorListDetailState {
  final String failReason;
  CoordinatorListDetailLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
