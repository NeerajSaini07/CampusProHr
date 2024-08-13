import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/getEmployeeTaskManagementModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/getEmployeeTaskManagementRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'get_employee_task_status_state.dart';

class GetEmployeeTaskStatusCubit extends Cubit<GetEmployeeTaskStatusState> {
  final GetEmployeeTaskManagementRepository _repository;
  GetEmployeeTaskStatusCubit(this._repository)
      : super(GetEmployeeTaskStatusInitial());

  Future<void> getEmployeeTaskStatusCubitCall(
      Map<String, String?> payload) async {
    if (await isInternetPresent()) {
      try {
        emit(GetEmployeeTaskStatusLoadInProgress());
        var data = await _repository.getEmployee(payload);
        emit(GetEmployeeTaskStatusLoadSuccess(data));
      } catch (e) {
        emit(GetEmployeeTaskStatusLoadFail('$e'));
      }
    } else {
      emit(GetEmployeeTaskStatusLoadFail(NO_INTERNET));
    }
  }
}
