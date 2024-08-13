import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/examAnalysisChartModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/examAnalysisChartRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'exam_analysis_chart_state.dart';

class ExamAnalysisChartCubit extends Cubit<ExamAnalysisChartState> {
  final ExamAnalysisChartRepository _repository;
  ExamAnalysisChartCubit(this._repository) : super(ExamAnalysisChartInitial());

  Future<void> examAnalysisChartCubitCall(Map<String, String?> examData) async {
    if (await isInternetPresent()) {
      try {
        emit(ExamAnalysisChartLoadInProgress());
        final data = await _repository.examAnalysisChart(examData);
        emit(ExamAnalysisChartLoadSuccess(data));
      } catch (e) {
        emit(ExamAnalysisChartLoadFail("$e"));
      }
    } else {
      emit(ExamAnalysisChartLoadFail(NO_INTERNET));
    }
  }
}