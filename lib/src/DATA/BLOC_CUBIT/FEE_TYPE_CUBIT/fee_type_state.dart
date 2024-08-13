part of 'fee_type_cubit.dart';

abstract class FeeTypeState extends Equatable {
  const FeeTypeState();
}

class FeeTypeInitial extends FeeTypeState {
  @override
  List<Object> get props => [];
}

class FeeTypeLoadInProgress extends FeeTypeState {
  @override
  List<Object> get props => [];
}

class FeeTypeLoadSuccess extends FeeTypeState {
  final List<FeeTypeModel> feeTypes;

  FeeTypeLoadSuccess(this.feeTypes);
  @override
  List<Object> get props => [feeTypes];
}

class FeeTypeLoadFail extends FeeTypeState {
  final String failReason;

  FeeTypeLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
