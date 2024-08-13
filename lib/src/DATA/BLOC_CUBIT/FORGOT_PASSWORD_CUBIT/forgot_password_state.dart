part of 'forgot_password_cubit.dart';

abstract class ForgotPasswordState extends Equatable {
  const ForgotPasswordState();
}

class ForgotPasswordInitial extends ForgotPasswordState {
  @override
  List<Object> get props => [];
}

class ForgotPasswordLoadSuccess extends ForgotPasswordState {
  final bool status;

  ForgotPasswordLoadSuccess(this.status);
  @override
  List<Object> get props => [status];
}

class ForgotPasswordLoadInProgress extends ForgotPasswordState {
  @override
  List<Object> get props => [];
}

class ForgotPasswordLoadFail extends ForgotPasswordState {
  final String failReason;

  ForgotPasswordLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
