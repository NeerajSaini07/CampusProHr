part of 'fee_balance_get_month_cubit.dart';

abstract class FeeBalanceGetMonthState extends Equatable {
  const FeeBalanceGetMonthState();
}

class FeeBalanceGetMonthInitial extends FeeBalanceGetMonthState {
  @override
  List<Object> get props => [];
}

class MonthListEmployeeLoadInProgress extends FeeBalanceGetMonthState {
  @override
  List<Object> get props => [];
}

class MonthListEmployeeLoadSuccess extends FeeBalanceGetMonthState {
  final List<FeeBalanceMonthListEmployeeModel> monthList;
  MonthListEmployeeLoadSuccess(this.monthList);
  @override
  List<Object> get props => [monthList];
}

class MonthListEmployeeLoadFail extends FeeBalanceGetMonthState {
  final String failReason;
  MonthListEmployeeLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
