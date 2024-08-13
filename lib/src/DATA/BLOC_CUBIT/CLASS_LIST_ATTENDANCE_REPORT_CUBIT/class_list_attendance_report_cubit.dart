import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/classListAttendanceReportModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/classListAttendanceReportRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'class_list_attendance_report_state.dart';

class ClassListAttendanceReportCubit
    extends Cubit<ClassListAttendanceReportState> {
  final ClassListAttendanceReportRepository repository;
  ClassListAttendanceReportCubit(this.repository)
      : super(ClassListAttendanceReportInitial());

  Future<void> classListAttendanceReportCubitCall(
      Map<String, String?> userTypeData) async {
    if (await isInternetPresent()) {
      try {
        emit(ClassListAttendanceReportLoadInProgress());
        final data = await repository.getClass(userTypeData);
        emit(ClassListAttendanceReportLoadSuccess(data));
      } catch (e) {
        emit(ClassListAttendanceReportLoadFail('$e'));
      }
    } else {
      emit(ClassListAttendanceReportLoadFail(NO_INTERNET));
    }
  }
}
