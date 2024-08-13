import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/attendanceEmployeeModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/attendanceEmployeeRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'attendance_employee_state.dart';

class AttendanceEmployeeCubit extends Cubit<AttendanceEmployeeState> {
  final AttendanceEmployeeRepository _repository;
  AttendanceEmployeeCubit(this._repository)
      : super(AttendanceEmployeeInitial());

  Future<void> attendanceEmployeeCubitCall(
      Map<String, String?> userTypeData) async {
    if (await isInternetPresent()) {
      try {
        emit(AttendanceEmployeeLoadInProgress());
        final data = await _repository.getAttendance(userTypeData);
        emit(AttendanceEmployeeLoadSuccess(data));
      } catch (e) {
        emit(AttendanceEmployeeLoadFail('$e'));
      }
    } else {
      emit(AttendanceEmployeeLoadFail(NO_INTERNET));
    }
  }
}
