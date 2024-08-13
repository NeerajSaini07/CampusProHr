import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/saveGardeEntryRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'save_grade_entry_state.dart';

class SaveGradeEntryCubit extends Cubit<SaveGradeEntryState> {
  //Dependency
  final SaveGradeEntryRepository _repository;

  SaveGradeEntryCubit(this._repository) : super(SaveGradeEntryInitial());

  Future<void> saveGradeEntryCubitCall(Map<String, String?> request) async {
    if (await isInternetPresent()) {
      try {
        emit(SaveGradeEntryLoadInProgress());
        final data = await _repository.gradeEntry(request);
        emit(SaveGradeEntryLoadSuccess(data));
      } catch (e) {
        emit(SaveGradeEntryLoadFail("$e"));
      }
    } else {
      emit(SaveGradeEntryLoadFail(NO_INTERNET));
    }
  }
}
