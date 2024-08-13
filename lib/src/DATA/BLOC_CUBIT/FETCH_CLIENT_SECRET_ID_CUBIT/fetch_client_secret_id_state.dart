part of 'fetch_client_secret_id_cubit.dart';

abstract class FetchClientSecretIdState extends Equatable {
  const FetchClientSecretIdState();
}

class FetchClientSecretIdInitial extends FetchClientSecretIdState {
  @override
  List<Object> get props => [];
}

class FetchClientSecretIdLoadInProgress extends FetchClientSecretIdState {
  @override
  List<Object> get props => [];
}

class FetchClientSecretIdLoadSuccess extends FetchClientSecretIdState {
  final FetchClientSecretIdModel clientIdData;

  FetchClientSecretIdLoadSuccess(this.clientIdData);
  @override
  List<Object> get props => [clientIdData];
}

class FetchClientSecretIdLoadFail extends FetchClientSecretIdState {
  final String failReason;

  FetchClientSecretIdLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
