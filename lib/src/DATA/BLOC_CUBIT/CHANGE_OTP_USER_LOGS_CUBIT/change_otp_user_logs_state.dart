part of 'change_otp_user_logs_cubit.dart';

abstract class ChangeOtpUserLogsState extends Equatable {
  const ChangeOtpUserLogsState();
}

class ChangeOtpUserLogsInitial extends ChangeOtpUserLogsState {
  @override
  List<Object> get props => [];
}

class ChangeOtpUserLogsLoadInProgress extends ChangeOtpUserLogsState {
  @override
  List<Object> get props => [];
}

class ChangeOtpUserLogsLoadSuccess extends ChangeOtpUserLogsState {
  final bool status;

  ChangeOtpUserLogsLoadSuccess(this.status);
  @override
  List<Object> get props => [status];
}

class ChangeOtpUserLogsLoadFail extends ChangeOtpUserLogsState {
  final String failReason;

  ChangeOtpUserLogsLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
