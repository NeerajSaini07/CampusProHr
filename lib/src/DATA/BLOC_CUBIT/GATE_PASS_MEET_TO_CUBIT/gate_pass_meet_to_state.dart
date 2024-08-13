part of 'gate_pass_meet_to_cubit.dart';

abstract class GatePassMeetToState extends Equatable {
  const GatePassMeetToState();
}

class GatePassMeetToInitial extends GatePassMeetToState {
  @override
  List<Object> get props => [];
}

class GatePassMeetToLoadInProgress extends GatePassMeetToState {
  @override
  List<Object> get props => [];
}

class GatePassMeetToLoadSuccess extends GatePassMeetToState {
  final List<GatePassMeetToModel> res;
  GatePassMeetToLoadSuccess(this.res);
  @override
  List<Object> get props => [res];
}

class GatePassMeetToLoadFail extends GatePassMeetToState {
  final String failReason;
  GatePassMeetToLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
