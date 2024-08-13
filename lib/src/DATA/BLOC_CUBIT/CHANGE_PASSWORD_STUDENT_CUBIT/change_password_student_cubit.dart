import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/changePasswordRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';
part 'change_password_student_state.dart';

class ChangePasswordStudentCubit extends Cubit<ChangePasswordStudentState> {
  final ChangePasswordStudentRepository _repository;
  ChangePasswordStudentCubit(this._repository)
      : super(ChangePasswordStudentInitial());

  Future<void> changePasswordStudentCubitCall(
      Map<String, String?> requestPayload) async {
    if (await isInternetPresent()) {
      try {
        emit(ChangePasswordStudentLoadInProgress());
        final data = await _repository.changePassword(requestPayload);
        emit(ChangePasswordStudentLoadSuccess(data));
      } catch (e) {
        emit(ChangePasswordStudentLoadFail("$e"));
      }
    } else {
      emit(ChangePasswordStudentLoadFail(NO_INTERNET));
    }
  }
}
