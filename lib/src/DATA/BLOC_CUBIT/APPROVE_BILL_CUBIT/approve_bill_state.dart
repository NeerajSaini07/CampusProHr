part of 'approve_bill_cubit.dart';

abstract class ApproveBillState extends Equatable {
  const ApproveBillState();
}

class ApproveBillInitial extends ApproveBillState {
  @override
  List<Object> get props => [];
}

class ApproveBillLoadInProgress extends ApproveBillState {
  @override
  List<Object> get props => [];
}

class ApproveBillLoadSuccess extends ApproveBillState {
  final bool status;

  ApproveBillLoadSuccess(this.status);
  @override
  List<Object> get props => [status];
}

class ApproveBillLoadFail extends ApproveBillState {
  final String failReason;

  ApproveBillLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
