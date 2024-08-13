import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/scheduleMeetingListAdminModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/scheduleMeetingListAdminRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'schedule_meeting_list_admin_state.dart';

class ScheduleMeetingListAdminCubit
    extends Cubit<ScheduleMeetingListAdminState> {
  final ScheduleMeetingListAdminRepository _repository;
  ScheduleMeetingListAdminCubit(this._repository)
      : super(ScheduleMeetingListAdminInitial());

  Future<void> scheduleMeetingListAdminCubitCall(
      Map<String, String?> meetingData) async {
    if (await isInternetPresent()) {
      try {
        emit(ScheduleMeetingListAdminLoadInProgress());
        final data = await _repository.meetingList(meetingData);
        emit(ScheduleMeetingListAdminLoadSuccess(data));
      } catch (e) {
        emit(ScheduleMeetingListAdminLoadFail("$e"));
      }
    } else {
      emit(ScheduleMeetingListAdminLoadFail(NO_INTERNET));
    }
  }
}
