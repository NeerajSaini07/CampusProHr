part of 'check_app_restriction_cubit.dart';

abstract class CheckAppRestrictionState extends Equatable {
  const CheckAppRestrictionState();
}

class CheckAppRestrictionInitial extends CheckAppRestrictionState {
  @override
  List<Object> get props => [];
}

class CheckAppRestrictionLoadInProgress extends CheckAppRestrictionState {
  @override
  List<Object> get props => [];
}

class CheckAppRestrictionLoadSuccess extends CheckAppRestrictionState {
  final bool status;

  CheckAppRestrictionLoadSuccess(this.status);
  @override
  List<Object> get props => [status];
}

class CheckAppRestrictionLoadFail extends CheckAppRestrictionState {
  final String failReason;

  CheckAppRestrictionLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
