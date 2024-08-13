import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/studentLeaveEmployeeModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/studentLeaveEmployeeRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'leave_employee_state.dart';

class StudentLeaveEmployeeCubit extends Cubit<LeaveEmployeeState> {
  final StudentLeaveEmployeeRepository _repository;
  StudentLeaveEmployeeCubit(this._repository) : super(LeaveEmployeeInitial());

  Future<void> studentLeaveEmployeeCubitCall(
      Map<String, String?> userTypeData) async {
    if (await isInternetPresent()) {
      try {
        emit(LeaveEmployeeLoadInProgress());
        final data = await _repository.studentLeave(userTypeData);
        emit(LeaveEmployeeLoadSuccess(data));
      } catch (e) {
        emit(LeaveEmployeeLoadFail('$e'));
      }
    } else {
      emit(LeaveEmployeeLoadFail(NO_INTERNET));
    }
  }
}
