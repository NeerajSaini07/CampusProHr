part of 'get_sms_type_sms_config_cubit.dart';

abstract class GetSmsTypeSmsConfigState extends Equatable {
  const GetSmsTypeSmsConfigState();
}

class GetSmsTypeSmsConfigInitial extends GetSmsTypeSmsConfigState {
  @override
  List<Object> get props => [];
}

class GetSmsTypeSmsConfigStateLoadInProgress extends GetSmsTypeSmsConfigState {
  @override
  List<Object> get props => [];
}

class GetSmsTypeSmsConfigStateLoadSuccess extends GetSmsTypeSmsConfigState {
  final List<GetSmsTypeSmsConfigModel> getSmsList;
  GetSmsTypeSmsConfigStateLoadSuccess(this.getSmsList);
  @override
  List<Object> get props => [getSmsList];
}

class GetSmsTypeSmsConfigStateLoadFail extends GetSmsTypeSmsConfigState {
  final String failReason;
  GetSmsTypeSmsConfigStateLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}