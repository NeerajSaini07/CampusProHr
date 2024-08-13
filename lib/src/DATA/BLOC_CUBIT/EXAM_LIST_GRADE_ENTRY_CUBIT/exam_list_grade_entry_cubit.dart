import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/examListGradeEntryModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/examListGradeEntryRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'exam_list_grade_entry_state.dart';

class ExamListGradeEntryCubit extends Cubit<ExamListGradeEntryState> {
  //Dependency
  final ExamListGradeEntryRepository _repository;

  ExamListGradeEntryCubit(this._repository) : super(ExamListGradeEntryInitial());

  Future<void> examListGradeEntryCubitCall(Map<String, String?> request) async {
    if (await isInternetPresent()) {
      try {
        emit(ExamListGradeEntryLoadInProgress());
        final data = await _repository.gradeEntry(request);
        emit(ExamListGradeEntryLoadSucccess(data));
      } catch (e) {
        emit(ExamListGradeEntryLoadFail("$e"));
      }
    } else {
      emit(ExamListGradeEntryLoadFail(NO_INTERNET));
    }
  }
}