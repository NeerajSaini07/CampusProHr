import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/ATTENDANCE_EMPLOYEE_CUBIT/attendance_employee_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/attendanceDetailModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/attendanceDetailRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'attendance_detail_state.dart';

class AttendanceDetailCubit extends Cubit<AttendanceDetailState> {
  final AttendanceDetailRepository repository;
  AttendanceDetailCubit(this.repository) : super(AttendanceDetailInitial());

  Future<void> attendanceDetailCubitCall(
      Map<String, String?> userTypeData) async {
    if (await isInternetPresent()) {
      try {
        emit(AttendanceDetailLoadInProgress());
        final data = await repository.getAttendanceDetail(userTypeData);
        emit(AttendanceDetailLoadSuccess(data));
      } catch (e) {
        emit(AttendanceDetailLoadFail('$e'));
      }
    } else {
      emit(AttendanceDetailLoadFail(NO_INTERNET));
    }
  }
}
