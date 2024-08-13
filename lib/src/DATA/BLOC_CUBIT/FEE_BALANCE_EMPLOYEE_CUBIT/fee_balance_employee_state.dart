part of 'fee_balance_employee_cubit.dart';

abstract class FeeBalanceEmployeeState extends Equatable {
  const FeeBalanceEmployeeState();
}

class FeeBalanceEmployeeInitial extends FeeBalanceEmployeeState {
  @override
  List<Object> get props => [];
}

class FeeBalanceEmployeeLoadInProgress extends FeeBalanceEmployeeState {
  @override
  List<Object> get props => [];
}

class FeeBalanceEmployeeLoadSuccess extends FeeBalanceEmployeeState {
  final List<FeeBalanceEmployeeModel> feeList;

  FeeBalanceEmployeeLoadSuccess(this.feeList);
  @override
  List<Object> get props => [feeList];
}

class FeeBalanceEmployeeLoadFail extends FeeBalanceEmployeeState {
  final String failReason;

  FeeBalanceEmployeeLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
