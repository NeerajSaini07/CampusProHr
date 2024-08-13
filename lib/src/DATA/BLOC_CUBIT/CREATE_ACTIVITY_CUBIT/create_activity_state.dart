part of 'create_activity_cubit.dart';

abstract class CreateActivityState extends Equatable {
  const CreateActivityState();
}

class CreateActivityInitial extends CreateActivityState {
  @override
  List<Object> get props => [];
}

class CreateActivityLoadInProgress extends CreateActivityState {
  @override
  List<Object> get props => [];
}

class CreateActivityLoadSuccess extends CreateActivityState {
  final String status;
  CreateActivityLoadSuccess(this.status);
  @override
  List<Object> get props => [status];
}

class CreateActivityLoadFail extends CreateActivityState {
  final String failReason;
  CreateActivityLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
