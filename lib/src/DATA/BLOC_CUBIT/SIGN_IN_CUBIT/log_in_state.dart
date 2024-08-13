part of 'log_in_cubit.dart';

abstract class LogInState extends Equatable {
  const LogInState();
}

class LogInInitial extends LogInState {
  @override
  List<Object> get props => [];
}

class LogInLoadInProgress extends LogInState {
  @override
  List<Object> get props => [];
}

class LogInLoadSuccess extends LogInState {
  final bool status;

  LogInLoadSuccess(this.status);
  @override
  List<Object> get props => [status];
}

class LogInLoadFail extends LogInState {
  final String failReason;

  LogInLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
