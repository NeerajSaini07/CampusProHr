import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/feeTypeSettingRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'fee_type_setting_state.dart';

class FeeTypeSettingCubit extends Cubit<FeeTypeSettingState> {
  final FeeTypeSettingRepository _repository;
  FeeTypeSettingCubit(this._repository) : super(FeeTypeSettingInitial());

  Future<void> feeTypeSettingCubitCall(Map<String, String?> feeData) async {
    if (await isInternetPresent()) {
      try {
        emit(FeeTypeSettingLoadInProgress());
        final data = await _repository.feeTypeSetting(feeData);
        emit(FeeTypeSettingLoadSuccess(data));
      } catch (e) {
        emit(FeeTypeSettingLoadFail("$e"));
      }
    } else {
      emit(FeeTypeSettingLoadFail(NO_INTERNET));
    }
  }
}