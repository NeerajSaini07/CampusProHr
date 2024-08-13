part of 'save_visitor_details_gate_pass_cubit.dart';

abstract class SaveVisitorDetailsGatePassState extends Equatable {
  const SaveVisitorDetailsGatePassState();
}

class SaveVisitorDetailsGatePassInitial
    extends SaveVisitorDetailsGatePassState {
  @override
  List<Object> get props => [];
}

class SaveVisitorDetailsGatePassLoadInProgress
    extends SaveVisitorDetailsGatePassState {
  @override
  List<Object> get props => [];
}

class SaveVisitorDetailsGatePassLoadSuccess
    extends SaveVisitorDetailsGatePassState {
  final String result;
  SaveVisitorDetailsGatePassLoadSuccess(this.result);

  @override
  List<Object> get props => [result];
}

class SaveVisitorDetailsGatePassLoadFail
    extends SaveVisitorDetailsGatePassState {
  final String failReason;
  SaveVisitorDetailsGatePassLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
