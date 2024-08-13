import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/attendanceOfEmployeeAdminModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/attendanceOfEmployeeAdminRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'attendance_of_employee_admin_state.dart';

class AttendanceOfEmployeeAdminCubit
    extends Cubit<AttendanceOfEmployeeAdminState> {
  final AttendanceOfEmployeeAdminRepository repository;
  AttendanceOfEmployeeAdminCubit(this.repository)
      : super(AttendanceOfEmployeeAdminInitial());

  Future<void> attendanceOfEmployeeAdminCubitCall(
      Map<String, String?> userTypeData) async {
    if (await isInternetPresent()) {
      try {
        emit(AttendanceOfEmployeeAdminLoadInProgress());
        final data = await repository.getAttendance(userTypeData);
        emit(AttendanceOfEmployeeAdminLoadSuccess(data));
      } catch (e) {
        emit(AttendanceOfEmployeeAdminLoadFail('$e'));
      }
    } else {
      emit(AttendanceOfEmployeeAdminLoadFail(NO_INTERNET));
    }
  }
}
