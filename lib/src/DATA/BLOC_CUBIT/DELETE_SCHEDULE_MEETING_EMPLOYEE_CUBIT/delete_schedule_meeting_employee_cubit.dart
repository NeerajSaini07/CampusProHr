import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/deleteScheduleMeetingEmployeeRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'delete_schedule_meeting_employee_state.dart';

class DeleteScheduleMeetingEmployeeCubit
    extends Cubit<DeleteScheduleMeetingEmployeeState> {
  final DeleteScheduleMeetingEmployeeRepository _repository;
  DeleteScheduleMeetingEmployeeCubit(this._repository)
      : super(DeleteScheduleMeetingEmployeeInitial());

  Future<void> deleteScheduleMeetingEmployeeCubitCall(
      Map<String, String?> deleteData) async {
    if (await isInternetPresent()) {
      try {
        emit(DeleteScheduleMeetingEmployeeLoadInProgress());
        final data = await _repository.deleteMeeting(deleteData);
        emit(DeleteScheduleMeetingEmployeeLoadSuccess(data));
      } catch (e) {
        emit(DeleteScheduleMeetingEmployeeLoadFail("$e"));
      }
    } else {
      emit(DeleteScheduleMeetingEmployeeLoadFail(NO_INTERNET));
    }
  }
}
