import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/activityModel.dart';
import 'package:campus_pro/src/DATA/MODELS/examMarksChartModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/activityRepository.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/examMarksChartRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'exam_marks_chart_state.dart';

class ExamMarksChartCubit extends Cubit<ExamMarksChartState> {
  final ExamMarksChartRepository _repository;
  ExamMarksChartCubit(this._repository) : super(ExamMarksChartInitial());

  Future<void> examMarksChartCubitCall(Map<String, String?> feeData) async {
    if (await isInternetPresent()) {
      try {
        emit(ExamMarksChartLoadInProgress());
        final data = await _repository.examMarksChart(feeData);
        emit(ExamMarksChartLoadSuccess(data));
      } catch (e) {
        emit(ExamMarksChartLoadFail("$e"));
      }
    } else {
      emit(ExamMarksChartLoadFail(NO_INTERNET));
    }
  }
}
