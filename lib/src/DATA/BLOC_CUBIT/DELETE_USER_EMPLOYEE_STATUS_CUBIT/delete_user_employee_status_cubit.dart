import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/deleteUserEmployeeStatusRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'delete_user_employee_status_state.dart';

class DeleteUserEmployeeStatusCubit
    extends Cubit<DeleteUserEmployeeStatusState> {
  //Dependency
  final DeleteUserEmployeeStatusRepository _repository;

  DeleteUserEmployeeStatusCubit(this._repository)
      : super(DeleteUserEmployeeStatusInitial());

  Future<void> deleteUserEmployeeStatusCubitCall(
      Map<String, String?> empData) async {
    if (await isInternetPresent()) {
      try {
        emit(DeleteUserEmployeeStatusLoadInProgress());
        final data = await _repository.deleteStatus(empData);
        emit(DeleteUserEmployeeStatusLoadSuccess(data));
      } catch (e) {
        emit(DeleteUserEmployeeStatusLoadFail("$e"));
      }
    } else {
      emit(DeleteUserEmployeeStatusLoadFail(NO_INTERNET));
    }
  }
}
