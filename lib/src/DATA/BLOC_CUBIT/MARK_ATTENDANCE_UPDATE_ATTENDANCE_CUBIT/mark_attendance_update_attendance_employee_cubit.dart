import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/markAttendanceUpdateAttendanceEmployeeRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'mark_attendance_update_attendance_employee_state.dart';

class MarkAttendanceUpdateAttendanceEmployeeCubit
    extends Cubit<MarkAttendanceUpdateAttendanceEmployeeState> {
  final MarkAttendanceUpdateAttendanceEmployeeRepository repository;
  MarkAttendanceUpdateAttendanceEmployeeCubit(this.repository)
      : super(MarkAttendanceUpdateAttendanceEmployeeInitial());

  Future<void> markAttendanceUpdateAttendanceEmployeeCubitCall(
      Map<String, String?> requestPayload) async {
    if (await isInternetPresent()) {
      try {
        emit(MarkAttendanceUpdateAttendanceLoadInProgress());
        final data = await repository.updateAttendance(requestPayload);
        emit(MarkAttendanceUpdateAttendanceLoadSuccess(data));
      } catch (e) {
        emit(MarkAttendanceUpdateAttendanceLoadFail("$e"));
      }
    } else {
      emit(MarkAttendanceUpdateAttendanceLoadFail(NO_INTERNET));
    }
  }
}
