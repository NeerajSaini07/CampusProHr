import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/scheduleMeetingListEmployeeModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/scheduleMeetingListEmployeeRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'schedule_meeting_list_employee_state.dart';

class ScheduleMeetingListEmployeeCubit
    extends Cubit<ScheduleMeetingListEmployeeState> {
  final ScheduleMeetingListEmployeeRepository _repository;
  ScheduleMeetingListEmployeeCubit(this._repository)
      : super(ScheduleMeetingListEmployeeInitial());

  Future<void> scheduleMeetingListEmployeeCubitCall(
      Map<String, String?> meetingData) async {
    if (await isInternetPresent()) {
      try {
        emit(ScheduleMeetingListEmployeeLoadInProgress());
        final data = await _repository.meetingList(meetingData);
        emit(ScheduleMeetingListEmployeeLoadSuccess(data));
      } catch (e) {
        emit(ScheduleMeetingListEmployeeLoadFail("$e"));
      }
    } else {
      emit(ScheduleMeetingListEmployeeLoadFail(NO_INTERNET));
    }
  }
}
