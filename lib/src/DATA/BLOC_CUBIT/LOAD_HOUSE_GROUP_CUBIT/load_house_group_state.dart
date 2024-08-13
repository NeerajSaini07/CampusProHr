part of 'load_house_group_cubit.dart';

abstract class LoadHouseGroupState extends Equatable {
  const LoadHouseGroupState();
}

class LoadHouseGroupInitial extends LoadHouseGroupState {
  @override
  List<Object> get props => [];
}

class LoadHouseGroupLoadInProgress extends LoadHouseGroupState {
  @override
  List<Object> get props => [];
}

class LoadHouseGroupLoadSuccess extends LoadHouseGroupState {
  final List<LoadHouseGroupModel> housesList;
  LoadHouseGroupLoadSuccess(this.housesList);
  @override
  List<Object> get props => [housesList];
}

class LoadHouseGroupLoadFail extends LoadHouseGroupState {
  final String failReason;
  LoadHouseGroupLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
