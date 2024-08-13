import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/activityModel.dart';
import 'package:campus_pro/src/DATA/MODELS/calenderStudentModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/activityRepository.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/calenderStudentRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'calender_student_state.dart';

class CalenderStudentCubit extends Cubit<CalenderStudentState> {
  final CalenderStudentRepository _repository;
  CalenderStudentCubit(this._repository) : super(CalenderStudentInitial());

  Future<void> calenderStudentCubitCall(
      Map<String, String?> requestPayload) async {
    if (await isInternetPresent()) {
      try {
        emit(CalenderStudentLoadInProgress());
        final data = await _repository.calenderStudent(requestPayload);
        emit(CalenderStudentLoadSuccess(data));
      } catch (e) {
        emit(CalenderStudentLoadFail("$e"));
      }
    } else {
      emit(CalenderStudentLoadFail(NO_INTERNET));
    }
  }
}
