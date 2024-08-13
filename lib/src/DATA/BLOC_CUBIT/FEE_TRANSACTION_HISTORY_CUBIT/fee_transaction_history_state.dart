part of 'fee_transaction_history_cubit.dart';

abstract class FeeTransactionHistoryState extends Equatable {
  const FeeTransactionHistoryState();
}

class FeeTransactionHistoryInitial extends FeeTransactionHistoryState {
  @override
  List<Object> get props => [];
}

class FeeTransactionHistoryLoadInProgress extends FeeTransactionHistoryState {
  @override
  List<Object> get props => [];
}

class FeeTransactionHistoryLoadSuccess extends FeeTransactionHistoryState {
  final List<FeeTransactionHistoryModel> transactionlist;

  FeeTransactionHistoryLoadSuccess(this.transactionlist);
  @override
  List<Object> get props => [transactionlist];
}

class FeeTransactionHistoryLoadFail extends FeeTransactionHistoryState {
  final String failReason;

  FeeTransactionHistoryLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
