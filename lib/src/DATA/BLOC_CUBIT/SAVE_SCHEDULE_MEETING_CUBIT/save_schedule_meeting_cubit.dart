import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/saveScheduleMeetingRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'save_schedule_meeting_state.dart';

class SaveScheduleMeetingCubit extends Cubit<SaveScheduleMeetingState> {
  final SaveScheduleMeetingRepository _repository;
  SaveScheduleMeetingCubit(this._repository)
      : super(SaveScheduleMeetingInitial());

  Future<void> saveScheduleMeetingCubitCall(
      Map<String, String?> meetingData) async {
    if (await isInternetPresent()) {
      try {
        emit(SaveScheduleMeetingLoadInProgress());
        final data = await _repository.saveMeeting(meetingData);
        emit(SaveScheduleMeetingLoadSuccess(data));
      } catch (e) {
        emit(SaveScheduleMeetingLoadFail("$e"));
      }
    } else {
      emit(SaveScheduleMeetingLoadFail(NO_INTERNET));
    }
  }
}
