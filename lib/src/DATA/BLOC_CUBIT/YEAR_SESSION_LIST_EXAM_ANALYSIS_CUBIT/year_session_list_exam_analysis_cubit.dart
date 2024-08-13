import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/yearSessionListExamAnalysisModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/yearSessionListExamAnalysisRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'year_session_list_exam_analysis_state.dart';

class YearSessionListExamAnalysisCubit extends Cubit<YearSessionListExamAnalysisState> {
  final YearSessionListExamAnalysisRepository _repository;
  YearSessionListExamAnalysisCubit(this._repository) : super(YearSessionListExamAnalysisInitial());

  Future<void> yearSessionListExamAnalysisCubitCall(Map<String, String?> yearData) async {
    if (await isInternetPresent()) {
      try {
        emit(YearSessionListExamAnalysisLoadInProgress());
        final data = await _repository.yearSessionListExamAnalysis(yearData);
        emit(YearSessionListExamAnalysisLoadSuccess(data));
      } catch (e) {
        emit(YearSessionListExamAnalysisLoadFail("$e"));
      }
    } else {
      emit(YearSessionListExamAnalysisLoadFail(NO_INTERNET));
    }
  }
}