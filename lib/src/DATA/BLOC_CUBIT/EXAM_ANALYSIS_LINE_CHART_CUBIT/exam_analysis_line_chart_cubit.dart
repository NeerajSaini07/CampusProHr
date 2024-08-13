import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/examAnalysisLineChartModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/examAnalysisLineChartRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'exam_analysis_line_chart_state.dart';

class ExamAnalysisLineChartCubit extends Cubit<ExamAnalysisLineChartState> {
  final ExamAnalysisLineChartRepository _repository;
  ExamAnalysisLineChartCubit(this._repository) : super(ExamAnalysisLineChartInitial());

  Future<void> examAnalysisLineChartCubitCall(Map<String, String?> examData) async {
    if (await isInternetPresent()) {
      try {
        emit(ExamAnalysisLineChartLoadInProgress());
        final data = await _repository.examAnalysisLineChart(examData);
        emit(ExamAnalysisLineChartLoadSuccess(data));
      } catch (e) {
        emit(ExamAnalysisLineChartLoadFail("$e"));
      }
    } else {
      emit(ExamAnalysisLineChartLoadFail(NO_INTERNET));
    }
  }
}