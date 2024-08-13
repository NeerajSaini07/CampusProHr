import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/assignClassTeacherAdminRepository.dart';

part 'assign_class_teacher_admin_state.dart';

class AssignClassTeacherAdminCubit extends Cubit<AssignClassTeacherAdminState> {
  final AssignClassTeacherAdminRepository repository;
  AssignClassTeacherAdminCubit(this.repository)
      : super(AssignClassTeacherAdminInitial());

  Future<void> assignClassTeacherAdminCubitCall(
      Map<String, String?> request) async {
    if (await isInternetPresent()) {
      try {
        emit(AssignClassTeacherAdminLoadInProgress());
        final data = await repository.assignClassTeacher(request);
        emit(AssignClassTeacherAdminLoadSuccess(data));
      } catch (e) {
        emit(AssignClassTeacherAdminLoadFail('$e'));
      }
    } else {
      emit(AssignClassTeacherAdminLoadFail(NO_INTERNET));
    }
  }
}
