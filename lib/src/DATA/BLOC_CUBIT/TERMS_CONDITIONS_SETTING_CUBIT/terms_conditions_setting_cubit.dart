import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/termsConditionsSettingRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'terms_conditions_setting_state.dart';

class TermsConditionsSettingCubit extends Cubit<TermsConditionsSettingState> {
  final TermsConditionsSettingRepository _repository;
  TermsConditionsSettingCubit(this._repository) : super(TermsConditionsSettingInitial());

  Future<void> termsConditionsSettingCubitCall(Map<String, String?> feeData) async {
    if (await isInternetPresent()) {
      try {
        emit(TermsConditionsSettingLoadInProgress());
        final data = await _repository.termsConditionsSetting(feeData);
        emit(TermsConditionsSettingLoadSuccess(data));
      } catch (e) {
        emit(TermsConditionsSettingLoadFail("$e"));
      }
    } else {
      emit(TermsConditionsSettingLoadFail(NO_INTERNET));
    }
  }
}