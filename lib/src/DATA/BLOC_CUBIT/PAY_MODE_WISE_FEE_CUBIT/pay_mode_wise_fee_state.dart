part of 'pay_mode_wise_fee_cubit.dart';

abstract class PayModeWiseFeeState extends Equatable {
  const PayModeWiseFeeState();
}

class PayModeWiseFeeInitial extends PayModeWiseFeeState {
  @override
  List<Object> get props => [];
}

class PayModeWiseFeeLoadInProgress extends PayModeWiseFeeState {
  @override
  List<Object> get props => [];
}

class PayModeWiseFeeLoadSuccess extends PayModeWiseFeeState {
  final PayModeWiseFeeModel payModeWiseFeeList;

  PayModeWiseFeeLoadSuccess(this.payModeWiseFeeList);
  @override
  List<Object> get props => [payModeWiseFeeList];
}

class PayModeWiseFeeLoadFail extends PayModeWiseFeeState {
  final String failReason;

  PayModeWiseFeeLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
