import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/classListAttendanceModel.dart';
import 'package:campus_pro/src/DATA/MODELS/classListAttendanceReportModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/classListAttendaceRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'class_list_att_report_state.dart';

class ClassListAttendanceCubit extends Cubit<ClassListAttReportState> {
  final ClassListAttendanceRepository repository;
  ClassListAttendanceCubit(this.repository)
      : super(ClassListAttReportInitial());

  Future<void> classListAttendanceCubitCall(
      Map<String, String?> userTypeData) async {
    if (await isInternetPresent()) {
      try {
        emit(ClassListAttReportLoadInProgress());
        final data = await repository.getClass(userTypeData);
        emit(ClassListAttReportLoadSuccess(data));
      } catch (e) {
        emit(ClassListAttReportLoadFail('$e'));
      }
    } else {
      emit(ClassListAttReportLoadFail(NO_INTERNET));
    }
  }
}
