import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/saveExamMarksRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'save_exam_marks_state.dart';

class SaveExamMarksCubit extends Cubit<SaveExamMarksState> {
  final SaveExamMarksRepository _repository;
  SaveExamMarksCubit(this._repository) : super(SaveExamMarksInitial());

  Future<void> saveExamMarksCubitCall(Map<String, String?> requestPayload) async {
    if (await isInternetPresent()) {
      try {
        emit(SaveExamMarksLoadInProgress());
        final data = await _repository.saveData(requestPayload);
        emit(SaveExamMarksLoadSuccess(data));
      } catch (e) {
        emit(SaveExamMarksLoadFail("$e"));
      }
    } else {
      emit(SaveExamMarksLoadFail(NO_INTERNET));
    }
  }
}