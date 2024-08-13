part of 'balance_fee_admin_cubit.dart';

abstract class BalanceFeeAdminState extends Equatable {
  const BalanceFeeAdminState();
}

class BalanceFeeAdminInitial extends BalanceFeeAdminState {
  @override
  List<Object> get props => [];
}

class BalanceFeeAdminLoadInProgress extends BalanceFeeAdminState {
  @override
  List<Object> get props => [];
}

class BalanceFeeAdminLoadSuccess extends BalanceFeeAdminState {
  final List<BalanceFeeAdminModel> balanceFeeAdmin;

  BalanceFeeAdminLoadSuccess(this.balanceFeeAdmin);
  @override
  List<Object> get props => [balanceFeeAdmin];
}

class BalanceFeeAdminLoadFail extends BalanceFeeAdminState {
  final String failReason;

  BalanceFeeAdminLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
