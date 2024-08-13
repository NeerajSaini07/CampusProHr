part of 'visitor_list_gate_pass_cubit.dart';

abstract class VisitorListGatePassState extends Equatable {
  const VisitorListGatePassState();
}

class VisitorListGatePassInitial extends VisitorListGatePassState {
  @override
  List<Object> get props => [];
}

class VisitorListGatePassLoadInProgress extends VisitorListGatePassState {
  @override
  List<Object> get props => [];
}

class VisitorListGatePassLoadSuccess extends VisitorListGatePassState {
  final List<VisitorListTodayGatePassModel> visitorList;
  VisitorListGatePassLoadSuccess(this.visitorList);
  @override
  List<Object> get props => [visitorList];
}

class VisitorListGatePassLoadFail extends VisitorListGatePassState {
  final String failReason;
  VisitorListGatePassLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
