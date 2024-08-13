import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/activityModel.dart';
import 'package:campus_pro/src/DATA/MODELS/assignTeacherModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/activityRepository.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/assignTeacherRepository.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/markAttendanceRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'mark_attendance_state.dart';

class MarkAttendanceCubit extends Cubit<MarkAttendanceState> {
  final MarkAttendanceRepository _repository;
  MarkAttendanceCubit(this._repository) : super(MarkAttendanceInitial());

  Future<void> markAttendanceCubitCall(Map<String, String?> markAttData) async {
    if (await isInternetPresent()) {
      try {
        emit(MarkAttendanceLoadInProgress());
        final data = await _repository.markAttendance(markAttData);
        emit(MarkAttendanceLoadSuccess(data));
      } catch (e) {
        emit(MarkAttendanceLoadFail("$e"));
      }
    } else {
      emit(MarkAttendanceLoadFail(NO_INTERNET));
    }
  }
}
