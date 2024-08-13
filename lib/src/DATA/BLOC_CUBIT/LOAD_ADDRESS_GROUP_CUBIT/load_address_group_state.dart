part of 'load_address_group_cubit.dart';

abstract class LoadAddressGroupState extends Equatable {
  const LoadAddressGroupState();
}

class LoadAddressGroupInitial extends LoadAddressGroupState {
  @override
  List<Object> get props => [];
}

class LoadAddressGroupLoadInProgress extends LoadAddressGroupState {
  @override
  List<Object> get props => [];
}

class LoadAddressGroupLoadSuccess extends LoadAddressGroupState {
  final List<LoadAddressGroupModel> addressList;
  LoadAddressGroupLoadSuccess(this.addressList);
  @override
  List<Object> get props => [addressList];
}

class LoadAddressGroupLoadFail extends LoadAddressGroupState {
  final String failReason;
  LoadAddressGroupLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
