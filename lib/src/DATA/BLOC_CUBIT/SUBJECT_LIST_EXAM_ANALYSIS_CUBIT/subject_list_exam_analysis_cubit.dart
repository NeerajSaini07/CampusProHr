import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/subjectListExamAnalysisModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/subjectListExamAnalysisRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'subject_list_exam_analysis_state.dart';


class SubjectListExamAnalysisCubit extends Cubit<SubjectListExamAnalysisState> {
  final SubjectListExamAnalysisRepository _repository;
  SubjectListExamAnalysisCubit(this._repository) : super(SubjectListExamAnalysisInitial());

  Future<void> subjectListExamAnalysisCubitCall(
      Map<String, String?> requestPayload) async {
    if (await isInternetPresent()) {
      try {
        emit(SubjectListExamAnalysisLoadInProgress());
        final data = await _repository.subjectListExamAnalysisData(requestPayload);
        emit(SubjectListExamAnalysisLoadSuccess(data));
      } catch (e) {
        emit(SubjectListExamAnalysisLoadFail("$e"));
      }
    } else {
      emit(SubjectListExamAnalysisLoadFail(NO_INTERNET));
    }
  }
}