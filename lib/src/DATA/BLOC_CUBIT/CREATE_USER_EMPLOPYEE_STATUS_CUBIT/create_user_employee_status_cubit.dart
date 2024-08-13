import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/createUserEmployeeStatusRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'create_user_employee_status_state.dart';

class CreateUserEmployeeStatusCubit extends Cubit<CreateUserEmployeeStatusState> {
  //Dependency
  final CreateUserEmployeeStatusRepository _repository;

  CreateUserEmployeeStatusCubit(this._repository)
      : super(CreateUserEmployeeStatusInitial());

  Future<void> createUserEmployeeStatusCubitCall(Map<String, String?> empData) async {
    if (await isInternetPresent()) {
      try {
        emit(CreateUserEmployeeStatusLoadInProgress());
        final data = await _repository.createStatus(empData);
        emit(CreateUserEmployeeStatusLoadSuccess(data));
      } catch (e) {
        emit(CreateUserEmployeeStatusLoadFail("$e"));
      }
    } else {
      emit(CreateUserEmployeeStatusLoadFail(NO_INTERNET));
    }
  }
}