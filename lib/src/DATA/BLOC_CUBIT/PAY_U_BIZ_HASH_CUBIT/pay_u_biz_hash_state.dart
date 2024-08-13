part of 'pay_u_biz_hash_cubit.dart';

abstract class PayUBizHashState extends Equatable {
  const PayUBizHashState();
}

class PayUBizHashInitial extends PayUBizHashState {
  @override
  List<Object> get props => [];
}

class PayUBizHashLoadInProgress extends PayUBizHashState {
  @override
  List<Object> get props => [];
}

class PayUBizHashLoadSuccess extends PayUBizHashState {
  final List<PayUBizHashModel> payUBizData;

  PayUBizHashLoadSuccess(this.payUBizData);
  @override
  List<Object> get props => [payUBizData];
}

class PayUBizHashLoadFail extends PayUBizHashState {
  final String failReason;

  PayUBizHashLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
