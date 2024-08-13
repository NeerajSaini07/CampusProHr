part of 'set_platform_cubit.dart';

abstract class SetPlatformState extends Equatable {
  const SetPlatformState();
}

class SetPlatformInitial extends SetPlatformState {
  @override
  List<Object> get props => [];
}

class SetPlatformLoadInProgress extends SetPlatformState {
  @override
  List<Object> get props => [];
}

class SetPlatformLoadSuccess extends SetPlatformState {
  final dynamic result;
  SetPlatformLoadSuccess(this.result);
  @override
  List<Object> get props => [result];
}

class SetPlatformLoadFail extends SetPlatformState {
  final String failReason;
  SetPlatformLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
