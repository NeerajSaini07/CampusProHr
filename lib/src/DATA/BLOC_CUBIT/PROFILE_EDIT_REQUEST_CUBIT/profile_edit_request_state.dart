part of 'profile_edit_request_cubit.dart';

abstract class ProfileEditRequestState extends Equatable {
  const ProfileEditRequestState();
}

class ProfileEditRequestInitial extends ProfileEditRequestState {
  @override
  List<Object> get props => [];
}

class ProfileEditRequestLoadInProgress extends ProfileEditRequestState {
  @override
  List<Object> get props => [];
}

class ProfileEditRequestLoadSuccess extends ProfileEditRequestState {
  final bool status;

  ProfileEditRequestLoadSuccess(this.status);
  @override
  List<Object> get props => [status];
}

class ProfileEditRequestLoadFail extends ProfileEditRequestState {
  final String failReason;

  ProfileEditRequestLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
