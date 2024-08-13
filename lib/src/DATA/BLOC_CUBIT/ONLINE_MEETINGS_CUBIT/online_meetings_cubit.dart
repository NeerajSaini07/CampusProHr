import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/activityModel.dart';
import 'package:campus_pro/src/DATA/MODELS/assignTeacherModel.dart';
import 'package:campus_pro/src/DATA/MODELS/onlineMeetingsModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/activityRepository.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/assignTeacherRepository.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/onlineMeetingsRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'online_meetings_state.dart';

class OnlineMeetingsCubit extends Cubit<OnlineMeetingsState> {
  final OnlineMeetingsRepository _repository;
  OnlineMeetingsCubit(this._repository) : super(OnlineMeetingsInitial());

  Future<void> onlineMeetingsCubitCall(Map<String, String?> meetingData) async {
    if (await isInternetPresent()) {
      try {
        emit(OnlineMeetingsLoadInProgress());
        final data = await _repository.onlineMeetings(meetingData);
        emit(OnlineMeetingsLoadSuccess(data));
      } catch (e) {
        emit(OnlineMeetingsLoadFail("$e"));
      }
    } else {
      emit(OnlineMeetingsLoadFail(NO_INTERNET));
    }
  }
}
