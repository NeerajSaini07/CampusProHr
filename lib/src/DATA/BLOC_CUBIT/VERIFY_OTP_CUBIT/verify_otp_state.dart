part of 'verify_otp_cubit.dart';

abstract class VerifyOtpState extends Equatable {
  const VerifyOtpState();
}

class VerifyOtpInitial extends VerifyOtpState {
  @override
  List<Object> get props => [];
}

class VerifyOtpLoadSuccess extends VerifyOtpState {
  final bool status;

  VerifyOtpLoadSuccess(this.status);
  @override
  List<Object> get props => [status];
}

class VerifyOtpLoadInProgress extends VerifyOtpState {
  @override
  List<Object> get props => [];
}

class VerifyOtpLoadFail extends VerifyOtpState {
  final String failReason;

  VerifyOtpLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
