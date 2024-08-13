part of 'fee_receipts_cubit.dart';

abstract class FeeReceiptsState extends Equatable {
  const FeeReceiptsState();
}

class FeeReceiptsInitial extends FeeReceiptsState {
  @override
  List<Object> get props => [];
}

class FeeReceiptsLoadInProgress extends FeeReceiptsState {
  @override
  List<Object> get props => [];
}

class FeeReceiptsLoadSuccess extends FeeReceiptsState {
  final List<FeeReceiptsModel> receiptsList;

  FeeReceiptsLoadSuccess(this.receiptsList);
  @override
  List<Object> get props => [receiptsList];
}

class FeeReceiptsLoadFail extends FeeReceiptsState {
  final String failReason;

  FeeReceiptsLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
