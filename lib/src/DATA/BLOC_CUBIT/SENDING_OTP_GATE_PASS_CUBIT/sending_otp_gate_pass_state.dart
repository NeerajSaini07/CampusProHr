part of 'sending_otp_gate_pass_cubit.dart';

abstract class SendingOtpGatePassState extends Equatable {
  const SendingOtpGatePassState();
}

class SendingOtpGatePassInitial extends SendingOtpGatePassState {
  @override
  List<Object> get props => [];
}

class SendingOtpGatePassLoadInProgress extends SendingOtpGatePassState {
  @override
  List<Object> get props => [];
}

class SendingOtpGatePassLoadSuccess extends SendingOtpGatePassState {
  final String result;
  SendingOtpGatePassLoadSuccess(this.result);
  @override
  List<Object> get props => [result];
}

class SendingOtpGatePassLoadFail extends SendingOtpGatePassState {
  final String failReason;
  SendingOtpGatePassLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
