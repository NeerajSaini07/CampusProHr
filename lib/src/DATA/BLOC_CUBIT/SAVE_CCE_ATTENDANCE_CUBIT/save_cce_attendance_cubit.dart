import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/saveCceAttendanceRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'save_cce_attendance_state.dart';

class SaveCceAttendanceCubit extends Cubit<SaveCceAttendanceState> {
  final SaveCceAttendanceRepository repository;
  SaveCceAttendanceCubit(this.repository) : super(SaveCceAttendanceInitial());

  Future<void> saveCceAttendanceCubitCall(Map<String, String?> request) async {
    if (await isInternetPresent()) {
      try {
        emit(SaveCceAttendanceLoadInProgress());
        var data = await repository.saveCceAttendance(request);
        emit(SaveCceAttendanceLoadSuccess(data));
      } catch (e) {
        emit(SaveCceAttendanceLoadFail('$e'));
      }
    } else {
      emit(SaveCceAttendanceLoadFail(NO_INTERNET));
    }
  }
}
