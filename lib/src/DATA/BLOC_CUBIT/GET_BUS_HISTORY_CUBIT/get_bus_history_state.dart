part of 'get_bus_history_cubit.dart';

abstract class GetBusHistoryState extends Equatable {
  const GetBusHistoryState();
}

class GetBusHistoryInitial extends GetBusHistoryState {
  @override
  List<Object> get props => [];
}

class GetBusHistoryLoadInProgress extends GetBusHistoryState {
  @override
  List<Object> get props => [];
}

class GetBusHistoryLoadSuccess extends GetBusHistoryState {
  final List<GetBusHistoryModel> history;
  GetBusHistoryLoadSuccess(this.history);
  @override
  List<Object> get props => [history];
}

class GetBusHistoryLoadFail extends GetBusHistoryState {
  final String failReason;
  GetBusHistoryLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
