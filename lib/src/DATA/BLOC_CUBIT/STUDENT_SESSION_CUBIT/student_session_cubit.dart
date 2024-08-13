import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/studentSessionModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/studentSessionRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'student_session_state.dart';

class StudentSessionCubit extends Cubit<StudentSessionState> {
  final StudentSessionRepository _repository;
  StudentSessionCubit(this._repository) : super(StudentSessionInitial());

  Future<void> studentSessionCubitCall(Map<String, String?> sessionData) async {
    if (await isInternetPresent()) {
      try {
        emit(StudentSessionLoadInProgress());
        final data = await _repository.studentSession(sessionData);
        emit(StudentSessionLoadSuccess(data));
      } catch (e) {
        emit(StudentSessionLoadFail("$e"));
      }
    } else {
      emit(StudentSessionLoadFail(NO_INTERNET));
    }
  }
}
