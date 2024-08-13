part of 'get_sms_type_detail_sms_confg_cubit.dart';

abstract class GetSmsTypeDetailSmsConfgState extends Equatable {
  const GetSmsTypeDetailSmsConfgState();
}

class GetSmsTypeDetailSmsConfgInitial extends GetSmsTypeDetailSmsConfgState {
  @override
  List<Object> get props => [];
}

class GetSmsTypeDetailSmsConfgLoadInProgress
    extends GetSmsTypeDetailSmsConfgState {
  @override
  List<Object> get props => [];
}

class GetSmsTypeDetailSmsConfgLoadSuccess
    extends GetSmsTypeDetailSmsConfgState {
  final List<GetSmsTypeDetailSmsConfigModel> typeDetailList;
  GetSmsTypeDetailSmsConfgLoadSuccess(this.typeDetailList);
  @override
  List<Object> get props => [typeDetailList];
}

class GetSmsTypeDetailSmsConfgLoadFail extends GetSmsTypeDetailSmsConfgState {
  final String failReason;
  GetSmsTypeDetailSmsConfgLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
