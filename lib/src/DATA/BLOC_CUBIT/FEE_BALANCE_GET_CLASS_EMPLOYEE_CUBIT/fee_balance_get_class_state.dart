part of 'fee_balance_get_class_cubit.dart';

abstract class FeeBalanceClassListEmployeeState extends Equatable {
  const FeeBalanceClassListEmployeeState();
}

class FeeBalanceGetClassInitial extends FeeBalanceClassListEmployeeState {
  @override
  List<Object> get props => [];
}

class ClassListEmployeeLoadInProgress extends FeeBalanceClassListEmployeeState {
  @override
  List<Object> get props => [];
}

class ClassListEmployeeLoadSuccess extends FeeBalanceClassListEmployeeState {
  final List<FeeBalanceClassListEmployeeModel> classList;
  ClassListEmployeeLoadSuccess(this.classList);
  @override
  List<Object> get props => [classList];
}

class ClassListEmployeeLoadFail extends FeeBalanceClassListEmployeeState {
  final String failReason;
  ClassListEmployeeLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
