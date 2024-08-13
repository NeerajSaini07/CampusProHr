import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/staffMeetingsEmployeeDashboardModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/staffMeetingsEmployeeDashboardRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'staff_meetings_employee_dashboard_state.dart';

class StaffMeetingsEmployeeDashboardCubit
    extends Cubit<StaffMeetingsEmployeeDashboardState> {
  final StaffMeetingsEmployeeDashboardRepository _repository;
  StaffMeetingsEmployeeDashboardCubit(this._repository)
      : super(StaffMeetingsEmployeeDashboardInitial());

  Future<void> staffMeetingsEmployeeDashboardCubitCall(Map<String, String?> meetingData) async {
    if (await isInternetPresent()) {
      try {
        emit(StaffMeetingsEmployeeDashboardLoadInProgress());
        final data = await _repository.onlineMeetings(meetingData);
        emit(StaffMeetingsEmployeeDashboardLoadSuccess(data));
      } catch (e) {
        emit(StaffMeetingsEmployeeDashboardLoadFail("$e"));
      }
    } else {
      emit(StaffMeetingsEmployeeDashboardLoadFail(NO_INTERNET));
    }
  }
}
