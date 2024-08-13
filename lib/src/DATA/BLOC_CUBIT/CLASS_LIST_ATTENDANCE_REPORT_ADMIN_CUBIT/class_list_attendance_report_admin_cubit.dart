import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/classListAttendanceReportAdminModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/ClassListAttendanceReportAdminRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'class_list_attendance_report_admin_state.dart';

class ClassListAttendanceReportAdminCubit
    extends Cubit<ClassListAttendanceReportAdminState> {
  final ClassListAttendanceReportAdminRepository repository;
  ClassListAttendanceReportAdminCubit(this.repository)
      : super(ClassListAttendanceReportAdminInitial());

  Future<void> classListAttendanceReportAdminCubitCall(
      Map<String, String?> userTypeData) async {
    if (await isInternetPresent()) {
      try {
        emit(ClassListAttendanceReportAdminLoadInProgress());
        final data = await repository.getClass(userTypeData);
        emit(ClassListAttendanceReportAdminLoadSuccess(data));
      } catch (e) {
        emit(ClassListAttendanceReportAdminLoadFail('$e'));
      }
    } else {
      emit(ClassListAttendanceReportAdminLoadFail(NO_INTERNET));
    }
  }
}
