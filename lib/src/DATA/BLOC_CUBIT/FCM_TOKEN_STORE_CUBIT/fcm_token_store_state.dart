part of 'fcm_token_store_cubit.dart';

abstract class FcmTokenStoreState extends Equatable {
  const FcmTokenStoreState();
}

class FcmTokenStoreInitial extends FcmTokenStoreState {
  @override
  List<Object> get props => [];
}

class FcmTokenStoreLoadInProgress extends FcmTokenStoreState {
  @override
  List<Object> get props => [];
}

class FcmTokenStoreLoadSuccess extends FcmTokenStoreState {
  final bool status;

  FcmTokenStoreLoadSuccess(this.status);
  @override
  List<Object> get props => [status];
}

class FcmTokenStoreLoadFail extends FcmTokenStoreState {
  final String? failReason;

  FcmTokenStoreLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason!];
}
