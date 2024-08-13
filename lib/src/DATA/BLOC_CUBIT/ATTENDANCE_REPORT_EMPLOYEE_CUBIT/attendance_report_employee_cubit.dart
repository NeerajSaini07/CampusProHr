import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/attendanceReportEmployeeModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/attendanceReportEmployeeRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'attendance_report_employee_state.dart';

class AttendanceReportEmployeeCubit
    extends Cubit<AttendanceReportEmployeeState> {
  final AttendanceReportEmployeeRepository repository;
  AttendanceReportEmployeeCubit(this.repository)
      : super(AttendanceReportEmployeeInitial());

  Future<void> attendanceReportEmployeeCubitCall(
      Map<String, String?> userTypeData) async {
    if (await isInternetPresent()) {
      try {
        emit(AttendanceReportEmployeeLoadInProgress());
        final data = await repository.getAttendanceReport(userTypeData);
        emit(AttendanceReportEmployeeLoadSuccess(data));
      } catch (e) {
        emit(AttendanceReportEmployeeLoadFail('$e'));
      }
    } else {
      emit(AttendanceReportEmployeeLoadFail(NO_INTERNET));
    }
  }
}
