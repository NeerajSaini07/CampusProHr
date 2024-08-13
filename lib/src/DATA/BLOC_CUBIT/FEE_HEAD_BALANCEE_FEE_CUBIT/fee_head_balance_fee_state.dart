part of 'fee_head_balance_fee_cubit.dart';

abstract class FeeHeadBalanceFeeState extends Equatable {
  const FeeHeadBalanceFeeState();
}

class FeeHeadBalanceFeeInitial extends FeeHeadBalanceFeeState {
  @override
  List<Object> get props => [];
}

class FeeHeadBalanceFeeLoadInProgress extends FeeHeadBalanceFeeState {
  @override
  List<Object> get props => [];
}

class FeeHeadBalanceFeeLoadSuccess extends FeeHeadBalanceFeeState {
  final List<FeeHeadBalanceFeeModel> feeHeads;

  FeeHeadBalanceFeeLoadSuccess(this.feeHeads);
  @override
  List<Object> get props => [feeHeads];
}

class FeeHeadBalanceFeeLoadFail extends FeeHeadBalanceFeeState {
  final String failReason;

  FeeHeadBalanceFeeLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
