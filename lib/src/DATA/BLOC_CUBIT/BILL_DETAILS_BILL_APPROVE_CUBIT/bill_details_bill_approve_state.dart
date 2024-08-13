part of 'bill_details_bill_approve_cubit.dart';

abstract class BillDetailsBillApproveState extends Equatable {
  const BillDetailsBillApproveState();
}

class BillDetailsBillApproveInitial extends BillDetailsBillApproveState {
  @override
  List<Object> get props => [];
}

class BillDetailsBillApproveLoadInProgress extends BillDetailsBillApproveState {
  @override
  List<Object> get props => [];
}

class BillDetailsBillApproveLoadSuccess extends BillDetailsBillApproveState {
  final BillDetailsBillApproveModel billDetailsBillApprove;

  BillDetailsBillApproveLoadSuccess(this.billDetailsBillApprove);
  @override
  List<Object> get props => [billDetailsBillApprove];
}

class BillDetailsBillApproveLoadFail extends BillDetailsBillApproveState {
  final String failReason;

  BillDetailsBillApproveLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
