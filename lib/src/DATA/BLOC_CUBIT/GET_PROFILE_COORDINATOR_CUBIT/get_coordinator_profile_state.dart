part of 'get_coordinator_profile_cubit.dart';

abstract class GetCoordinatorProfileState extends Equatable {
  const GetCoordinatorProfileState();
}

class GetCoordinatorProfileInitial extends GetCoordinatorProfileState {
  @override
  List<Object> get props => [];
}

class GetCoordinatorProfileLoadInProgress extends GetCoordinatorProfileState {
  @override
  List<Object> get props => [];
}

class GetCoordinatorProfileLoadSuccess extends GetCoordinatorProfileState {
  final List<GetCoordinatorProfileModel> profileDetails;
  GetCoordinatorProfileLoadSuccess(this.profileDetails);
  @override
  List<Object> get props => [profileDetails];
}

class GetCoordinatorProfileLoadFail extends GetCoordinatorProfileState {
  final String failReason;
  GetCoordinatorProfileLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
