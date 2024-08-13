import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/examsListExamAnalysisModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/examsListExamAnalysisRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'exams_list_exam_analysis_state.dart';

class ExamsListExamAnalysisCubit extends Cubit<ExamsListExamAnalysisState> {
  final ExamsListExamAnalysisRepository _repository;
  ExamsListExamAnalysisCubit(this._repository) : super(ExamsListExamAnalysisInitial());

  Future<void> examListExamAnalysisCubitCall(Map<String, String?> examData) async {
    if (await isInternetPresent()) {
      try {
        emit(ExamsListExamAnalysisLoadInProgress());
        final data = await _repository.examsListExamAnalysis(examData);
        emit(ExamsListExamAnalysisLoadSuccess(data));
      } catch (e) {
        emit(ExamsListExamAnalysisLoadFail("$e"));
      }
    } else {
      emit(ExamsListExamAnalysisLoadFail(NO_INTERNET));
    }
  }
}