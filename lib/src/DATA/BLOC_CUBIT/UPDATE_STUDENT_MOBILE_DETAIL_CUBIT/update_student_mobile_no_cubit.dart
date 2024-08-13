import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/updateStudentMobileNoRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'update_student_mobile_no_state.dart';

class UpdateStudentMobileNoCubit extends Cubit<UpdateStudentMobileNoState> {
  //Dependency
  final UpdateStudentMobileNoRepository _repository;

  UpdateStudentMobileNoCubit(this._repository)
      : super(UpdateStudentMobileNoInitial());

  Future<void> updateStudentMobileNoCubitCall(
      Map<String, String?> studentData) async {
    if (await isInternetPresent()) {
      try {
        emit(UpdateStudentMobileNoLoadInProgress());
        final data = await _repository.updateStudent(studentData);
        emit(UpdateStudentMobileNoLoadSuccess(data));
      } catch (e) {
        emit(UpdateStudentMobileNoLoadFail("$e"));
      }
    } else {
      emit(UpdateStudentMobileNoLoadFail(NO_INTERNET));
    }
  }
}
