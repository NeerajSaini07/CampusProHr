import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/scheduleMeetingTodayListModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/scheduleMeetingTodayListRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'schedule_meeting_today_list_state.dart';

class ScheduleMeetingTodayListCubit
    extends Cubit<ScheduleMeetingTodayListState> {
  final ScheduleMeetingTodayListRepository _repository;
  ScheduleMeetingTodayListCubit(this._repository)
      : super(ScheduleMeetingTodayListInitial());

  Future<void> scheduleMeetingTodayListCubitCall(
      Map<String, String?> meetingData) async {
    if (await isInternetPresent()) {
      try {
        emit(ScheduleMeetingTodayListLoadInProgress());
        final data = await _repository.meetingList(meetingData);
        emit(ScheduleMeetingTodayListLoadSuccess(data));
      } catch (e) {
        emit(ScheduleMeetingTodayListLoadFail("$e"));
      }
    } else {
      emit(ScheduleMeetingTodayListLoadFail(NO_INTERNET));
    }
  }
}
