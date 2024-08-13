part of 'bills_list_bill_approve_cubit.dart';

abstract class BillsListBillApproveState extends Equatable {
  const BillsListBillApproveState();
}

class BillsListBillApproveInitial extends BillsListBillApproveState {
  @override
  List<Object> get props => [];
}

class BillsListBillApproveLoadInProgress extends BillsListBillApproveState {
  @override
  List<Object> get props => [];
}

class BillsListBillApproveLoadSuccess extends BillsListBillApproveState {
  final List<BillsListBillApproveModel> billsListBillApprove;

  BillsListBillApproveLoadSuccess(this.billsListBillApprove);
  @override
  List<Object> get props => [billsListBillApprove];
}

class BillsListBillApproveLoadFail extends BillsListBillApproveState {
  final String failReason;

  BillsListBillApproveLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
