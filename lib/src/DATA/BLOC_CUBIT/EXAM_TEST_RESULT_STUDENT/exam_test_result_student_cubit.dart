import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/activityModel.dart';
import 'package:campus_pro/src/DATA/MODELS/examTestResultStudentModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/activityRepository.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/examTestResultStudentRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'exam_test_result_student_state.dart';

class ExamTestResultStudentCubit extends Cubit<ExamTestResultStudentState> {
  final ExamTestResultStudentRepository _repository;
  ExamTestResultStudentCubit(this._repository)
      : super(ExamTestResultStudentInitial());

  Future<void> examTestResultStudentCubitCall(
      Map<String, String?> requestPayload) async {
    if (await isInternetPresent()) {
      try {
        emit(ExamTestResultStudentLoadInProgress());
        final data = await _repository.resultData(requestPayload);
        emit(ExamTestResultStudentLoadSuccess(data));
      } catch (e) {
        emit(ExamTestResultStudentLoadFail("$e"));
      }
    } else {
      emit(ExamTestResultStudentLoadFail(NO_INTERNET));
    }
  }
}
