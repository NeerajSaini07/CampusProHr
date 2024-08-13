import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/activityModel.dart';
import 'package:campus_pro/src/DATA/MODELS/assignTeacherModel.dart';
import 'package:campus_pro/src/DATA/MODELS/selfAttendanceSettingModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/activityRepository.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/assignTeacherRepository.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/selfAttendanceSettingRepository.dart.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'self_attendance_setting_state.dart';

class SelfAttendanceSettingCubit extends Cubit<SelfAttendanceSettingState> {
  final SelfAttendanceSettingRepository _repository;
  SelfAttendanceSettingCubit(this._repository)
      : super(SelfAttendanceSettingInitial());

  Future<void> selfAttendanceSettingCubitCall(
      Map<String, String?> schoolData) async {
    if (await isInternetPresent()) {
      try {
        emit(SelfAttendanceSettingLoadInProgress());
        final data = await _repository.selfAttendanceSetting(schoolData);
        emit(SelfAttendanceSettingLoadSuccess(data));
      } catch (e) {
        emit(SelfAttendanceSettingLoadFail("$e"));
      }
    } else {
      emit(SelfAttendanceSettingLoadFail(NO_INTERNET));
    }
  }
}
