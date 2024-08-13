import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/getEmployeeTaskManagementModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/getEmployeeTaskManagementRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'get_task_task_management_state.dart';

class GetTaskTaskManagementCubit extends Cubit<GetTaskTaskManagementState> {
  final GetEmployeeTaskManagementRepository _repository;
  GetTaskTaskManagementCubit(this._repository)
      : super(GetTaskTaskManagementInitial());

  Future<void> getTaskTaskManagementCubitCall(
      Map<String, String?> payload) async {
    if (await isInternetPresent()) {
      try {
        emit(GetTaskTaskManagementLoadInProgress());
        var data = await _repository.getEmployee(payload);
        emit(GetTaskTaskManagementLoadSuccess(data));
      } catch (e) {
        emit(GetTaskTaskManagementLoadFail('$e'));
      }
    } else {
      emit(GetTaskTaskManagementLoadFail(NO_INTERNET));
    }
  }
}
