import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/activityModel.dart';
import 'package:campus_pro/src/DATA/MODELS/assignTeacherModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/activityRepository.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/assignTeacherRepository.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/studentChoiceSessionRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'student_choice_session_state.dart';

class StudentChoiceSessionCubit extends Cubit<StudentChoiceSessionState> {
  final StudentChoiceSessionRepository _repository;
  StudentChoiceSessionCubit(this._repository)
      : super(StudentChoiceSessionInitial());

  Future<void> studentChoiceSessionCubitCall(
      Map<String, String?> sessionData) async {
    if (await isInternetPresent()) {
      try {
        emit(StudentChoiceSessionLoadInProgress());
        final data = await _repository.studentChoiceSession(sessionData);
        emit(StudentChoiceSessionLoadSuccess(data));
      } catch (e) {
        emit(StudentChoiceSessionLoadFail("$e"));
      }
    } else {
      emit(StudentChoiceSessionLoadFail(NO_INTERNET));
    }
  }
}
