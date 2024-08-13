import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/sectionListAttendanceModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/sectionListAttendanceRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'section_list_attendance_state.dart';

class SectionListAttendanceCubit extends Cubit<SectionListAttendanceState> {
  final SectionListAttendanceRepository repository;
  SectionListAttendanceCubit(this.repository)
      : super(SectionListAttendanceInitial());

  Future<void> sectionListAttendanceCubitCall(
      Map<String, String?> userTypeData) async {
    if (await isInternetPresent()) {
      try {
        emit(SectionListAttendanceLoadInProgress());
        final data = await repository.getSection(userTypeData);
        emit(SectionListAttendanceLoadSuccess(data));
      } catch (e) {
        emit(SectionListAttendanceLoadFail('$e'));
      }
    } else {
      emit(SectionListAttendanceLoadFail(NO_INTERNET));
    }
  }
}
