import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/studentLeaveEmployeeHistoryModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/studentLeaveEmployeeHistoryRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'student_history_employee_state.dart';

class StudentHistoryLeaveEmployeeCubit
    extends Cubit<StudentHistoryEmployeeState> {
  final StudentLeaveEmployeeHistoryRepository _repository;
  StudentHistoryLeaveEmployeeCubit(this._repository)
      : super(StudentHistoryEmployeeInitial());

  Future<void> studentHistoryEmployeeCubitCall(
      Map<String, String?> userTypeData) async {
    if (await isInternetPresent()) {
      try {
        emit(StudentHistoryEmployeeLoadInProgress());
        final data = await _repository.studentLeave(userTypeData);
        emit(StudentHistoryEmployeeLoadSuccess(data));
      } catch (e) {
        emit(StudentHistoryEmployeeLoadFail('$e'));
      }
    } else {
      emit(StudentHistoryEmployeeLoadFail(NO_INTERNET));
    }
  }
}
