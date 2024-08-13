import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/activityModel.dart';
import 'package:campus_pro/src/DATA/MODELS/attendanceGraphModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/activityRepository.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/attendanceGraphRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'attendance_graph_state.dart';

class AttendanceGraphCubit extends Cubit<AttendanceGraphState> {
  final AttendanceGraphRepository _repository;
  AttendanceGraphCubit(this._repository) : super(AttendanceGraphInitial());

  Future<void> attendanceGraphCubitCall(
      Map<String, String?> requestPayload) async {
    if (await isInternetPresent()) {
      try {
        emit(AttendanceGraphLoadInProgress());
        final data = await _repository.attendanceGraph(requestPayload);
        emit(AttendanceGraphLoadSuccess(data));
      } catch (e) {
        emit(AttendanceGraphLoadFail("$e"));
      }
    } else {
      emit(AttendanceGraphLoadFail(NO_INTERNET));
    }
  }
}
