part of 'discount_apply_and_reject_cubit.dart';

abstract class DiscountApplyAndRejectState extends Equatable {
  const DiscountApplyAndRejectState();
}

class DiscountApplyAndRejectInitial extends DiscountApplyAndRejectState {
  @override
  List<Object> get props => [];
}

class DiscountApplyAndRejectLoadInProgress extends DiscountApplyAndRejectState {
  @override
  List<Object> get props => [];
}

class DiscountApplyAndRejectLoadSuccess extends DiscountApplyAndRejectState {
  final bool status;

  DiscountApplyAndRejectLoadSuccess(this.status);
  @override
  List<Object> get props => [status];
}

class DiscountApplyAndRejectLoadFail extends DiscountApplyAndRejectState {
  final String failReason;

  DiscountApplyAndRejectLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
