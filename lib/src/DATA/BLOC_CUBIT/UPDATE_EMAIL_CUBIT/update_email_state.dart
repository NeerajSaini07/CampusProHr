part of 'update_email_cubit.dart';

abstract class UpdateEmailState extends Equatable {
  const UpdateEmailState();
}

class UpdateEmailInitial extends UpdateEmailState {
  @override
  List<Object> get props => [];
}

class UpdateEmailLoadSuccess extends UpdateEmailState {
  final bool status;

  UpdateEmailLoadSuccess(this.status);
  @override
  List<Object> get props => [status];
}

class UpdateEmailLoadInProgress extends UpdateEmailState {
  @override
  List<Object> get props => [];
}

class UpdateEmailLoadFail extends UpdateEmailState {
  final String failReason;

  UpdateEmailLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
