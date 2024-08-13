part of 'party_type_bill_approve_cubit.dart';

abstract class PartyTypeBillApproveState extends Equatable {
  const PartyTypeBillApproveState();
}

class PartyTypeBillApproveInitial extends PartyTypeBillApproveState {
  @override
  List<Object> get props => [];
}

class PartyTypeBillApproveLoadInProgress extends PartyTypeBillApproveState {
  @override
  List<Object> get props => [];
}

class PartyTypeBillApproveLoadSuccess extends PartyTypeBillApproveState {
  final List<PartyTypeBillApproveModel> partyTypeBillApprove;

  PartyTypeBillApproveLoadSuccess(this.partyTypeBillApprove);
  @override
  List<Object> get props => [partyTypeBillApprove];
}

class PartyTypeBillApproveLoadFail extends PartyTypeBillApproveState {
  final String failReason;

  PartyTypeBillApproveLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
