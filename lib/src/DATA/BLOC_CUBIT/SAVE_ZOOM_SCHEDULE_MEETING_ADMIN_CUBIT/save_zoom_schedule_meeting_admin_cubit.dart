import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/saveZoomScheduleMeetingAdminRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'save_zoom_schedule_meeting_admin_state.dart';

class SaveZoomScheduleMeetingAdminCubit extends Cubit<SaveZoomScheduleMeetingAdminState> {
  final SaveZoomScheduleMeetingAdminRepository _repository;

  SaveZoomScheduleMeetingAdminCubit(this._repository) : super(SaveZoomScheduleMeetingAdminInitial());
  Future<void> saveZoomScheduleMeetingAdminCubitCall(
      Map<String, String?> meetingData) async {
    if (await isInternetPresent()) {
      try {
        emit(SaveZoomScheduleMeetingAdminLoadInProgress());
        final data = await _repository.scheduleMeetingAdmin(meetingData);
        emit(SaveZoomScheduleMeetingAdminLoadSuccess(data));
      } catch (e) {
        emit(SaveZoomScheduleMeetingAdminLoadFail("$e"));
      }
    } else {
      emit(SaveZoomScheduleMeetingAdminLoadFail(NO_INTERNET));
    }
  }
}