import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/sectionListAttendanceAdminModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/SectionListAttendanceAdminRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'section_list_attendance_admin_state.dart';

class SectionListAttendanceAdminCubit
    extends Cubit<SectionListAttendanceAdminState> {
  final SectionListAttendanceAdminRepository repository;
  SectionListAttendanceAdminCubit(this.repository)
      : super(SectionListAttendanceAdminInitial());

  Future<void> sectionListAttendanceAdminCubitCall(
      Map<String, String?> request) async {
    if (await isInternetPresent()) {
      try {
        emit(SectionListAttendanceAdminLoadInProgress());
        final data = await repository.getSection(request);
        emit(SectionListAttendanceAdminLoadSuccess(data));
      } catch (e) {
        emit(SectionListAttendanceAdminLoadFail('$e'));
      }
    } else {
      emit(SectionListAttendanceAdminLoadFail(NO_INTERNET));
    }
  }
}
