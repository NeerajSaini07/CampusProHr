import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/activityModel.dart';
import 'package:campus_pro/src/DATA/MODELS/leaveRequestModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/activityRepository.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/leaveRequestRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'leave_request_state.dart';

class LeaveRequestCubit extends Cubit<LeaveRequestState> {
  final LeaveRequestRepository _repository;
  LeaveRequestCubit(this._repository) : super(LeaveRequestInitial());

  Future<void> leaveRequestCubitCall(
      Map<String, String?> requestPayload) async {
    if (await isInternetPresent()) {
      try {
        emit(LeaveRequestLoadInProgress());
        final data = await _repository.leaveRequest(requestPayload);
        emit(LeaveRequestLoadSuccess(data));
      } catch (e) {
        emit(LeaveRequestLoadFail("$e"));
      }
    } else {
      emit(LeaveRequestLoadFail(NO_INTERNET));
    }
  }
}
