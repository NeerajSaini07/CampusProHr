part of 'fee_months_cubit.dart';

abstract class FeeMonthsState extends Equatable {
  const FeeMonthsState();
}

class FeeMonthsInitial extends FeeMonthsState {
  @override
  List<Object> get props => [];
}

class FeeMonthsLoadInProgress extends FeeMonthsState {
  @override
  List<Object> get props => [];
}

class FeeMonthsLoadSuccess extends FeeMonthsState {
  final List<FeeMonthsModel> feeMonths;

  FeeMonthsLoadSuccess(this.feeMonths);
  @override
  List<Object> get props => [feeMonths];
}

class FeeMonthsLoadFail extends FeeMonthsState {
  final String failReason;

  FeeMonthsLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
