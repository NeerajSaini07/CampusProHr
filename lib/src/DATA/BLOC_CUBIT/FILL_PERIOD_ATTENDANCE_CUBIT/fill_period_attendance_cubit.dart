import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/fillPeriodAttendanceRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'fill_period_attendance_state.dart';

class FillPeriodAttendanceCubit extends Cubit<FillPeriodAttendanceState> {
  final FillPeriodAttendanceRepository _repository;
  FillPeriodAttendanceCubit(this._repository)
      : super(FillPeriodAttendanceInitial());

  Future<void> fillPeriod(Map<String, String?> request) async {
    if (await isInternetPresent()) {
      try {
        emit(FillPeriodAttendanceLoadInProgress());
        var data = await _repository.fillPeriod(request);
        emit(FillPeriodAttendanceLoadSuccess(data));
      } catch (e) {
        emit(FillPeriodAttendanceLoadFail('$e'));
      }
    } else {
      emit(FillPeriodAttendanceLoadFail(NO_INTERNET));
    }
  }
}
