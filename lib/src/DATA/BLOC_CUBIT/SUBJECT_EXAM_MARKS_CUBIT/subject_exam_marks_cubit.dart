import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/subjectExamMarkModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/subjectExamMarksRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'subject_exam_marks_state.dart';

class SubjectExamMarksCubit extends Cubit<SubjectExamMarksState> {
  final SubjectExamMarksRepository _repository;
  SubjectExamMarksCubit(this._repository) : super(SubjectExamMarksInitial());

  Future<void> subjectExamMarksCubitCall(
      Map<String, String?> requestPayload) async {
    if (await isInternetPresent()) {
      try {
        emit(SubjectExamMarksLoadInProgress());
        final data = await _repository.subjectData(requestPayload);
        emit(SubjectExamMarksLoadSuccess(data));
      } catch (e) {
        emit(SubjectExamMarksLoadFail("$e"));
      }
    } else {
      emit(SubjectExamMarksLoadFail(NO_INTERNET));
    }
  }
}
