part of 'user_school_detail_cubit.dart';

abstract class UserSchoolDetailState extends Equatable {
  const UserSchoolDetailState();
}

class UserSchoolDetailInitial extends UserSchoolDetailState {
  @override
  List<Object> get props => [];
}

class UserSchoolDetailLoadInProgress extends UserSchoolDetailState {
  @override
  List<Object> get props => [];
}

class UserSchoolDetailLoadSuccess extends UserSchoolDetailState {
  final UserSchoolDetailModel schoolData;

  UserSchoolDetailLoadSuccess(this.schoolData);
  @override
  List<Object> get props => [schoolData];
}

class UserSchoolDetailLoadFail extends UserSchoolDetailState {
  final String? failReason;

  UserSchoolDetailLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason!];
}
