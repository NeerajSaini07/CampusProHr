part of 'otp_user_list_cubit.dart';

abstract class OtpUserListState extends Equatable {
  const OtpUserListState();
}

class OtpUserListInitial extends OtpUserListState {
  @override
  List<Object> get props => [];
}

class OtpUserListLoadInProgress extends OtpUserListState {
  @override
  List<Object> get props => [];
}

class OtpUserListLoadSuccess extends OtpUserListState {
  final List<OtpUserListModel> otpUserList;

  OtpUserListLoadSuccess(this.otpUserList);
  @override
  List<Object> get props => [otpUserList];
}

class OtpUserListLoadFail extends OtpUserListState {
  final String failReason;

  OtpUserListLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
