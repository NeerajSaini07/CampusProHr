import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/appConfigSettingModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/appConfigSettingRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'app_config_setting_state.dart';

class AppConfigSettingCubit extends Cubit<AppConfigSettingState> {
  final AppConfigSettingRepository _repository;
  AppConfigSettingCubit(this._repository) : super(AppConfigSettingInitial());

  Future<void> appConfigSettingCubitCall(
      Map<String, String?> schoolData) async {
    if (await isInternetPresent()) {
      try {
        emit(AppConfigSettingLoadInProgress());
        final data = await _repository.appConfigSetting(schoolData);
        emit(AppConfigSettingLoadSuccess(data));
      } catch (e) {
        emit(AppConfigSettingLoadFail("$e"));
      }
    } else {
      emit(AppConfigSettingLoadFail(NO_INTERNET));
    }
  }
}
