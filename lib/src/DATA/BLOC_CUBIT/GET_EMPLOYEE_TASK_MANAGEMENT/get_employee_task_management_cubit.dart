import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/getEmployeeTaskManagementModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/getEmployeeTaskManagementRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'get_employee_task_management_state.dart';

class GetEmployeeTaskManagementCubit
    extends Cubit<GetEmployeeTaskManagementState> {
  final GetEmployeeTaskManagementRepository _repository;
  GetEmployeeTaskManagementCubit(this._repository)
      : super(GetEmployeeTaskManagementInitial());

  Future<void> getEmployeeTaskManagementCubitCall(
      Map<String, String?> payload) async {
    if (await isInternetPresent()) {
      try {
        emit(GetEmployeeTaskManagementLoadInProgress());
        var data = await _repository.getEmployee(payload);
        emit(GetEmployeeTaskManagementLoadSuccess(data));
      } catch (e) {
        emit(GetEmployeeTaskManagementLoadFail('$e'));
      }
    } else {
      emit(GetEmployeeTaskManagementLoadFail(NO_INTERNET));
    }
  }
}
