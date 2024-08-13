import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/getSmsTypeDetailSmsConfigModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/getSmsTypeDetailSmsConfigRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'get_sms_type_detail_sms_confg_state.dart';

class GetSmsTypeDetailSmsConfgCubit
    extends Cubit<GetSmsTypeDetailSmsConfgState> {
  final GetSmsTypeDetailSmsConfigRepository _repository;
  GetSmsTypeDetailSmsConfgCubit(this._repository)
      : super(GetSmsTypeDetailSmsConfgInitial());

  Future<void> getSmsTypeDetailSmsConfgCubitCall(
      Map<String, String?> request) async {
    if (await isInternetPresent()) {
      try {
        emit(GetSmsTypeDetailSmsConfgLoadInProgress());
        var data = await _repository.getSmsTypeDetail(request);
        emit(GetSmsTypeDetailSmsConfgLoadSuccess(data));
      } catch (e) {
        emit(GetSmsTypeDetailSmsConfgLoadFail('$e'));
      }
    } else {
      emit(GetSmsTypeDetailSmsConfgLoadFail(NO_INTERNET));
    }
  }
}
