import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/examAnalysisChartAdminModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/examAnalysisChartAdminRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'exam_analysis_chart_admin_state.dart';



class ExamAnalysisChartAdminCubit extends Cubit<ExamAnalysisChartAdminState> {
  final ExamAnalysisChartAdminRepository _repository;
  ExamAnalysisChartAdminCubit(this._repository) : super(ExamAnalysisChartAdminInitial());

  Future<void> examAnalysisChartAdminCubitCall(
      Map<String, String?> requestPayload) async {
    if (await isInternetPresent()) {
      try {
        emit(ExamAnalysisChartAdminLoadInProgress());
        final data = await _repository.examAnalysisChartAdminData(requestPayload);
        emit(ExamAnalysisChartAdminLoadSuccess(data));
      } catch (e) {
        emit(ExamAnalysisChartAdminLoadFail("$e"));
      }
    } else {
      emit(ExamAnalysisChartAdminLoadFail(NO_INTERNET));
    }
  }
}