import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/gradesListGradeEntryModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/gradesListGradeEntryRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'grades_list_grade_entry_state.dart';

class GradesListGradeEntryCubit extends Cubit<GradesListGradeEntryState> {
  //Dependency
  final GradeListGradeEntryRepository _repository;

  GradesListGradeEntryCubit(this._repository) : super(GradesListGradeEntryInitial());

  Future<void> gradesListGradeEntryCubitCall(Map<String, String?> request) async {
    if (await isInternetPresent()) {
      try {
        emit(GradesListGradeEntryLoadInProgress());
        final data = await _repository.gradeEntry(request);
        emit(GradesListGradeEntryLoadSuccess(data));
      } catch (e) {
        emit(GradesListGradeEntryLoadFail("$e"));
      }
    } else {
      emit(GradesListGradeEntryLoadFail(NO_INTERNET));
    }
  }
}