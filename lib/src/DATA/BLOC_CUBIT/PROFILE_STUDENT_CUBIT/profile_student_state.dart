part of 'profile_student_cubit.dart';

abstract class ProfileStudentState extends Equatable {
  const ProfileStudentState();
}

class ProfileStudentInitial extends ProfileStudentState {
  @override
  List<Object> get props => [];
}

class ProfileStudentLoadInProgress extends ProfileStudentState {
  @override
  List<Object> get props => [];
}

class ProfileStudentLoadSuccess extends ProfileStudentState {
  final List<ProfileStudentModel> profileData;
  ProfileStudentLoadSuccess(this.profileData);
  @override
  List<Object> get props => [profileData];
}

class ProfileStudentLoadFail extends ProfileStudentState {
  final String failReason;
  ProfileStudentLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
