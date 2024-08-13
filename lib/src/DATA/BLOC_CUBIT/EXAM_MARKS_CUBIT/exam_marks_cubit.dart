import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/activityModel.dart';
import 'package:campus_pro/src/DATA/MODELS/examMarksModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/activityRepository.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/examMarksRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'exam_marks_state.dart';

class ExamMarksCubit extends Cubit<ExamMarksState> {
  final ExamMarksRepository _repository;
  ExamMarksCubit(this._repository) : super(ExamMarksInitial());

  Future<void> examMarksCubitCall(Map<String, String?> feeData) async {
    if (await isInternetPresent()) {
      try {
        emit(ExamMarksLoadInProgress());
        final data = await _repository.examMarks(feeData);
        emit(ExamMarksLoadSuccess(data));
      } catch (e) {
        emit(ExamMarksLoadFail("$e"));
      }
    } else {
      emit(ExamMarksLoadFail(NO_INTERNET));
    }
  }
}
