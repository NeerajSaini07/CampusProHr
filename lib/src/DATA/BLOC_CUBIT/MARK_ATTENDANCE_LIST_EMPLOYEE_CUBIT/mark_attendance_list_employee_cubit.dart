import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/MARK_ATTENDANCE_CUBIT/mark_attendance_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/markAttendanceListEmployeeModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/markAttendanceListEmployeeRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'mark_attendance_list_employee_state.dart';

class MarkAttendanceListEmployeeCubit
    extends Cubit<MarkAttendanceListEmployeeState> {
  final MarkAttendanceListEmployeeRepository repository;
  MarkAttendanceListEmployeeCubit(this.repository)
      : super(MarkAttendanceListEmployeeInitial());

  Future<void> markAttendanceListEmployeeCubitCall(
      Map<String, String?> markAttData) async {
    if (await isInternetPresent()) {
      try {
        emit(MarkAttendanceListLoadInProgress());
        final data = await repository.getAttList(markAttData);
        emit(MarkAttendanceListLoadSuccess(data));
      } catch (e) {
        emit(MarkAttendanceListLoadFail("$e"));
      }
    } else {
      emit(MarkAttendanceListLoadFail(NO_INTERNET));
    }
  }
}
