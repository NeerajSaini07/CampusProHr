import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/markAttendacePeriodsEmployeeModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/markAttendacePeriodsEmployeeRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'mark_attendance_employee_state.dart';

class MarkAttendancePeriodsEmployeeCubit
    extends Cubit<MarkAttendanceEmployeeState> {
  final MarkAttendancePeriodsEmployeeRepository repository;
  MarkAttendancePeriodsEmployeeCubit(this.repository)
      : super(MarkAttendanceEmployeeInitial());

  Future<void> markAttendancePeriodsEmployeeCubitCall(
      Map<String, String?> userTypeData, int? number) async {
    if (await isInternetPresent()) {
      try {
        emit(MarkAttendanceEmployeeLoadInProgress());
        final data = await repository.getPeriods(userTypeData, number);
        emit(MarkAttendanceEmployeeLoadSuccess(data));
      } catch (e) {
        emit(MarkAttendanceEmployeeLoadFail('$e'));
      }
    } else {
      emit(MarkAttendanceEmployeeLoadFail(NO_INTERNET));
    }
  }
}
