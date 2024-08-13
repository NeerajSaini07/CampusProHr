import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/activityForStudentModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/activityForStudentRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'activity_for_student_state.dart';

class ActivityForStudentCubit extends Cubit<ActivityForStudentState> {
  final ActivityForStudentRepository _repository;
  ActivityForStudentCubit(this._repository)
      : super(ActivityForStudentInitial());

  Future<void> activityForStudentCubitCall(Map<String, String?> request) async {
    if (await isInternetPresent()) {
      try {
        emit(ActivityForStudentLoadInProgress());
        var data = await _repository.getActivity(request);
        emit(ActivityForStudentLoadSuccess(data));
      } catch (e) {
        emit(ActivityForStudentLoadFail('$e'));
      }
    } else {
      emit(ActivityForStudentLoadFail(NO_INTERNET));
    }
  }
}
