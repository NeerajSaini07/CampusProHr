import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/activityModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/activityRepository.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/applyForLeaveRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'apply_for_leave_state.dart';

class ApplyForLeaveCubit extends Cubit<ApplyForLeaveState> {
  final ApplyForLeaveRepository _repository;
  ApplyForLeaveCubit(this._repository) : super(ApplyForLeaveInitial());

  Future<void> applyForLeaveCubitCall(
      Map<String, String?> requestPayload) async {
    if (await isInternetPresent()) {
      try {
        emit(ApplyForLeaveLoadInProgress());
        final data = await _repository.applyForLeave(requestPayload);
        emit(ApplyForLeaveLoadSuccess(data));
      } catch (e) {
        emit(ApplyForLeaveLoadFail("$e"));
      }
    } else {
      emit(ApplyForLeaveLoadFail(NO_INTERNET));
    }
  }
}
