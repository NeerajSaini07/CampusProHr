import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/activityModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/activityRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'activity_state.dart';

class ActivityCubit extends Cubit<ActivityState> {
  final ActivityRepository _repository;
  ActivityCubit(this._repository) : super(ActivityInitial());

  Future<void> activityCubitCall(Map<String, String?> requestPayload) async {
    if (await isInternetPresent()) {
      try {
        emit(ActivityLoadInProgress());
        final data = await _repository.showActivityData(requestPayload);
        emit(ActivityLoadSuccess(data));
      } catch (e) {
        emit(ActivityLoadFail("$e"));
      }
    } else {
      emit(ActivityLoadFail(NO_INTERNET));
    }
  }
}
