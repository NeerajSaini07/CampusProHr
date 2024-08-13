part of 'verify_id_proof_gate_pass_cubit.dart';

abstract class VerifyIdProofGatePassState extends Equatable {
  const VerifyIdProofGatePassState();
}

class VerifyIdProofGatePassInitial extends VerifyIdProofGatePassState {
  @override
  List<Object> get props => [];
}

class VerifyIdProofGatePassLoadInProgress extends VerifyIdProofGatePassState {
  @override
  List<Object> get props => [];
}

class VerifyIdProofGatePassLoadSuccess extends VerifyIdProofGatePassState {
  final String result;
  VerifyIdProofGatePassLoadSuccess(this.result);
  @override
  List<Object> get props => [result];
}

class VerifyIdProofGatePassLoadFail extends VerifyIdProofGatePassState {
  final String failReason;
  VerifyIdProofGatePassLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
