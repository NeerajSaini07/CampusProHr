import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/saveZoomScheduleMeetingRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'save_zoom_schedule_meeting_state.dart';

class SaveZoomScheduleMeetingCubit extends Cubit<SaveZoomScheduleMeetingState> {
  final SaveZoomScheduleMeetingRepository _repository;

  SaveZoomScheduleMeetingCubit(this._repository) : super(SaveZoomScheduleMeetingInitial());
  Future<void> saveZoomScheduleMeetingCubitCall(
      Map<String, String?> meetingData) async {
    if (await isInternetPresent()) {
      try {
        emit(SaveZoomScheduleMeetingLoadInProgress());
        final data = await _repository.scheduleMeeting(meetingData);
        emit(SaveZoomScheduleMeetingLoadSuccess(data));
      } catch (e) {
        emit(SaveZoomScheduleMeetingLoadFail("$e"));
      }
    } else {
      emit(SaveZoomScheduleMeetingLoadFail(NO_INTERNET));
    }
  }
}