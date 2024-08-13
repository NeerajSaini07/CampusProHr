import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/studentLeavePendingRejectAcceptRepository.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/studentLeavePendingRejectAcceptModel.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'student_leave_pending_reject_accept_state.dart';

class StudentLeavePendingRejectAcceptCubit
    extends Cubit<StudentLeavePendingRejectAcceptState> {
  final studentLeavePendingRejectAcceptRepository _repository;
  StudentLeavePendingRejectAcceptCubit(this._repository)
      : super(StudentLeavePendingRejectAcceptInitial());

  Future<void> studentLeavePendingRejectAcceptCall(
      Map<String, String?> userTypeData) async {
    if (await isInternetPresent()) {
      try {
        emit(StudentLeavePendingRejectAcceptLoadInProgress());
        final data = await _repository.studentLeaveRejectAccept(userTypeData);
        emit(StudentLeavePendingRejectAcceptLoadSuccess(data));
      } catch (e) {
        emit(StudentLeavePendingRejectAcceptLoadFail('$e'));
      }
    } else {
      emit(StudentLeavePendingRejectAcceptLoadFail(NO_INTERNET));
    }
  }
}
