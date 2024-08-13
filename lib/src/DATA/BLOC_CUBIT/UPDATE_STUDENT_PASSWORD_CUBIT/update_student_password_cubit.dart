import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/updateStudentPasswordRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'update_student_password_state.dart';

class UpdateStudentPasswordCubit extends Cubit<UpdateStudentPasswordState> {
  //Dependency
  final UpdateStudentPasswordRepository _repository;

  UpdateStudentPasswordCubit(this._repository)
      : super(UpdateStudentPasswordInitial());

  Future<void> updateStudentPasswordCubitCall(
      Map<String, String?> studentData) async {
    if (await isInternetPresent()) {
      try {
        emit(UpdateStudentPasswordLoadInProgress());
        final data = await _repository.updateStudent(studentData);
        emit(UpdateStudentPasswordLoadSuccess(data));
      } catch (e) {
        emit(UpdateStudentPasswordLoadFail("$e"));
      }
    } else {
      emit(UpdateStudentPasswordLoadFail(NO_INTERNET));
    }
  }
}
