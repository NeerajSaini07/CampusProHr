part of 'pay_u_money_hash_cubit.dart';

abstract class PayUMoneyHashState extends Equatable {
  const PayUMoneyHashState();
}

class PayUMoneyHashInitial extends PayUMoneyHashState {
  @override
  List<Object> get props => [];
}

class PayUMoneyHashLoadInProgress extends PayUMoneyHashState {
  @override
  List<Object> get props => [];
}

class PayUMoneyHashLoadSuccess extends PayUMoneyHashState {
  final List<PayUMoneyHashModel> payUMoneyData;

  PayUMoneyHashLoadSuccess(this.payUMoneyData);
  @override
  List<Object> get props => [payUMoneyData];
}

class PayUMoneyHashLoadFail extends PayUMoneyHashState {
  final String failReason;

  PayUMoneyHashLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
