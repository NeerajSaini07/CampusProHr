part of 'verify_otp_gate_pass_cubit.dart';

abstract class VerifyOtpGatePassState extends Equatable {
  const VerifyOtpGatePassState();
}

class VerifyOtpGatePassInitial extends VerifyOtpGatePassState {
  @override
  List<Object> get props => [];
}

class VerifyOtpGatePassLoadInProgress extends VerifyOtpGatePassState {
  @override
  List<Object> get props => [];
}

class VerifyOtpGatePassLoadSuccess extends VerifyOtpGatePassState {
  final String result;
  VerifyOtpGatePassLoadSuccess(this.result);
  @override
  List<Object> get props => [result];
}

class VerifyOtpGatePassLoadFail extends VerifyOtpGatePassState {
  final String failReason;
  VerifyOtpGatePassLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
