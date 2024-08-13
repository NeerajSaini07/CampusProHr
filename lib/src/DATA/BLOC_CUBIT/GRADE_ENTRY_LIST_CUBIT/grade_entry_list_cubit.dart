import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/gradeEntryListModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/gradeEntryListRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'grade_entry_list_state.dart';

class GradeEntryListCubit extends Cubit<GradeEntryListState> {
  //Dependency
  final GradeEntryListRepository _repository;

  GradeEntryListCubit(this._repository) : super(GradeEntryListInitial());

  Future<void> gradeEntryListCubitCall(Map<String, String?> request) async {
    if (await isInternetPresent()) {
      try {
        emit(GradeEntryListLoadInProgress());
        final data = await _repository.gradeEntry(request);
        emit(GradeEntryListLoadSuccess(data));
      } catch (e) {
        emit(GradeEntryListLoadFail("$e"));
      }
    } else {
      emit(GradeEntryListLoadFail(NO_INTERNET));
    }
  }
}
