import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/markAttendanceSaveAttedanceRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'mark_attendance_save_attendance_state.dart';

class MarkAttendanceSaveAttendanceEmployeeCubit
    extends Cubit<MarkAttendanceSaveAttendanceEmployeeState> {
  final MarkAttendanceSaveAttendanceEmployeeRepository repository;
  MarkAttendanceSaveAttendanceEmployeeCubit(this.repository)
      : super(MarkAttendanceSaveAttendanceInitial());

  Future<void> markAttendanceSaveAttendanceCubitCall(
      Map<String, String?> requestPayload) async {
    if (await isInternetPresent()) {
      try {
        emit(MarkAttendanceSaveAttendanceLoadInProgress());
        final data = await repository.saveAttendance(requestPayload);
        emit(MarkAttendanceSaveAttendanceLoadSuccess(data));
      } catch (e) {
        emit(MarkAttendanceSaveAttendanceLoadFail("$e"));
      }
    } else {
      emit(MarkAttendanceSaveAttendanceLoadFail(NO_INTERNET));
    }
  }
}
