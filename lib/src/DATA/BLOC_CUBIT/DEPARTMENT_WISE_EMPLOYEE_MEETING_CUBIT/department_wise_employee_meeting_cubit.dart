import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/departmentWiseEmployeeMeetingModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/departmentWiseEmployeeMeetingRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'department_wise_employee_meeting_state.dart';

class DepartmentWiseEmployeeMeetingCubit extends Cubit<DepartmentWiseEmployeeMeetingState> {
  //Dependency
  final DepartmentWiseEmployeeMeetingRepository _repository;

  DepartmentWiseEmployeeMeetingCubit(this._repository) : super(DepartmentWiseEmployeeMeetingInitial());

  Future<void> departmentWiseEmployeeMeetingCubitCall(Map<String, String> departmentData) async {
    if (await isInternetPresent()) {
      try {
        emit(DepartmentWiseEmployeeMeetingLoadInProgress());
        final data = await _repository.getDepartments(departmentData);
        emit(DepartmentWiseEmployeeMeetingLoadSuccess(data));
      } catch (e) {
        emit(DepartmentWiseEmployeeMeetingLoadFail("$e"));
      }
    } else {
      emit(DepartmentWiseEmployeeMeetingLoadFail(NO_INTERNET));
    }
  }
}