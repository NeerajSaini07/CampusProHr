import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/resultAnnounceExamModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/resultAnnounceExamRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'result_announce_exam_state.dart';

class ResultAnnounceExamCubit extends Cubit<ResultAnnounceExamState> {
  final ResultAnnounceExamRepository repository;
  ResultAnnounceExamCubit(this.repository) : super(ResultAnnounceExamInitial());

  Future<void> resultAnnounceExamCubitCall(Map<String, dynamic> request) async {
    if (await isInternetPresent()) {
      try {
        emit(ResultAnnounceExamLoadInProgress());
        final data = await repository.getExam(request);
        emit(ResultAnnounceExamLoadSuccess(data));
      } catch (e) {
        emit(ResultAnnounceExamLoadFail('$e'));
      }
    } else {
      emit(ResultAnnounceExamLoadFail(NO_INTERNET));
    }
  }
}
