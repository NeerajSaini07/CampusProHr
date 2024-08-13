import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/preClassExamAnalysisRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'pre_class_exam_analysis_state.dart';

class PreClassExamAnalysisCubit extends Cubit<PreClassExamAnalysisState> {
  final PreClassExamAnalysisRepository _repository;
  PreClassExamAnalysisCubit(this._repository) : super(PreClassExamAnalysisInitial());

  Future<void> preClassExamAnalysisCubitCall(
      Map<String, String?> requestPayload) async {
    if (await isInternetPresent()) {
      try {
        emit(PreClassExamAnalysisLoadInProgress());
        final data = await _repository.preClassExamAnalysisData(requestPayload);
        emit(PreClassExamAnalysisLoadSuccess(data));
      } catch (e) {
        emit(PreClassExamAnalysisLoadFail("$e"));
      }
    } else {
      emit(PreClassExamAnalysisLoadFail(NO_INTERNET));
    }
  }
}