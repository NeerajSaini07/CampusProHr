import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/createUserStudentStatusRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'create_user_student_status_state.dart';

class CreateUserStudentStatusCubit extends Cubit<CreateUserStudentStatusState> {
  final CreateUserStudentStatusRepository _repository;
  CreateUserStudentStatusCubit(this._repository)
      : super(CreateUserStudentStatusInitial());

  Future<void> createUserStudentStatusCubitCall(
      Map<String, String?> createUserData) async {
    if (await isInternetPresent()) {
      try {
        emit(CreateUserStudentStatusLoadInProgress());
        final data = await _repository.createUserStudentStatus(createUserData);
        emit(CreateUserStudentStatusLoadSuccess(data));
      } catch (e) {
        emit(CreateUserStudentStatusLoadFail("$e"));
      }
    } else {
      emit(CreateUserStudentStatusLoadFail(NO_INTERNET));
    }
  }
}
