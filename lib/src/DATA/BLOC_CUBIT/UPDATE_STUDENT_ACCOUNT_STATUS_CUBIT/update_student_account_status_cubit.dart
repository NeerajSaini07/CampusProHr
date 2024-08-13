import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/updateStudentAccountStatusRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'update_student_account_status_state.dart';

class UpdateStudentAccountStatusCubit
    extends Cubit<UpdateStudentAccountStatusState> {
  //Dependency
  final UpdateStudentAccountStatusRepository _repository;

  UpdateStudentAccountStatusCubit(this._repository)
      : super(UpdateStudentAccountStatusInitial());

  Future<void> updateStudentAccountStatusCubitCall(
      Map<String, String?> studentData) async {
    if (await isInternetPresent()) {
      try {
        emit(UpdateStudentAccountStatusLoadInProgress());
        final data = await _repository.updateStudent(studentData);
        emit(UpdateStudentAccountStatusLoadSuccess(data));
      } catch (e) {
        emit(UpdateStudentAccountStatusLoadFail("$e"));
      }
    } else {
      emit(UpdateStudentAccountStatusLoadFail(NO_INTERNET));
    }
  }
}
