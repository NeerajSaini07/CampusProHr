import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/getEmployeeTaskManagementModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/getEmployeeTaskManagementRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'get_employee_task_management2_state.dart';

class GetEmployeeTaskManagement2Cubit
    extends Cubit<GetEmployeeTaskManagement2State> {
  final GetEmployeeTaskManagementRepository _repository;
  GetEmployeeTaskManagement2Cubit(this._repository)
      : super(GetEmployeeTaskManagement2Initial());

  Future<void> getEmployeeTaskManagement2CubitCall(
      Map<String, String?> payload) async {
    if (await isInternetPresent()) {
      try {
        emit(GetEmployeeTaskManagement2LoadInProgress());
        var data = await _repository.getEmployee(payload);
        emit(GetEmployeeTaskManagement2LoadSuccess(data));
      } catch (e) {
        emit(GetEmployeeTaskManagement2LoadFail('$e'));
      }
    } else {
      emit(GetEmployeeTaskManagement2LoadFail(NO_INTERNET));
    }
  }
}
