part of 'fee_remark_cubit.dart';

abstract class FeeRemarkState extends Equatable {
  const FeeRemarkState();
}

class FeeRemarkInitial extends FeeRemarkState {
  @override
  List<Object> get props => [];
}

class FeeRemarkLoadInProgress extends FeeRemarkState {
  @override
  List<Object> get props => [];
}

class FeeRemarkLoadSuccess extends FeeRemarkState {
  final FeeRemarksModel feeRemarks;

  FeeRemarkLoadSuccess(this.feeRemarks);
  @override
  List<Object> get props => [feeRemarks];
}

class FeeRemarkLoadFail extends FeeRemarkState {
  final String failReason;

  FeeRemarkLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
