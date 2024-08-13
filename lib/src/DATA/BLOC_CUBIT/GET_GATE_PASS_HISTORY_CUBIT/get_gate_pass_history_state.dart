part of 'get_gate_pass_history_cubit.dart';

abstract class GetGatePassHistoryState extends Equatable {
  const GetGatePassHistoryState();
}

class GetGatePassHistoryInitial extends GetGatePassHistoryState {
  @override
  List<Object> get props => [];
}

class GetGatePassHistoryLoadInProgress extends GetGatePassHistoryState {
  @override
  List<Object> get props => [];
}

class GetGatePassHistoryLoadSuccess extends GetGatePassHistoryState {
  final List<GetGatePassHistoryModal> historyList;
  GetGatePassHistoryLoadSuccess(this.historyList);
  @override
  List<Object> get props => [historyList];
}

class GetGatePassHistoryLoadFail extends GetGatePassHistoryState {
  final String failReason;
  GetGatePassHistoryLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
