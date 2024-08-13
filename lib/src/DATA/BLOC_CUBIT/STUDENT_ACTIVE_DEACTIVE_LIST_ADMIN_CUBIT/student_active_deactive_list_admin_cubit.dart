import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/studentActiveDeactiveListAdminRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'student_active_deactive_list_admin_state.dart';

class StudentActiveDeactiveListAdminCubit
    extends Cubit<StudentActiveDeactiveListAdminState> {
  //Dependency
  final StudentActiveDeactiveListAdminRepository _repository;

  StudentActiveDeactiveListAdminCubit(this._repository)
      : super(StudentActiveDeactiveListAdminInitial());

  Future<void> studentActiveDeactiveListAdminCubitCall(
      Map<String, String> studentData) async {
    if (await isInternetPresent()) {
      try {
        emit(StudentActiveDeactiveListAdminLoadInProgress());
        final data =
            await _repository.studentActiveDeactiveListAdmin(studentData);
        emit(StudentActiveDeactiveListAdminLoadSuccess(data));
      } catch (e) {
        emit(StudentActiveDeactiveListAdminLoadFail("$e"));
      }
    } else {
      emit(StudentActiveDeactiveListAdminLoadFail(NO_INTERNET));
    }
  }
}
