import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/saveCceSubjectTeacherRemarksRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'save_cce_subject_teacher_remarks_state.dart';

class SaveCceSubjectTeacherRemarksCubit extends Cubit<SaveCceSubjectTeacherRemarksState> {
  //Dependency
  final SaveCceSubjectTeacherRemarksRepository _repository;

  SaveCceSubjectTeacherRemarksCubit(this._repository)
      : super(SaveCceSubjectTeacherRemarksInitial());

  Future<void> saveCceSubjectTeacherRemarksCubitCall(
      Map<String, String?> request) async {
    if (await isInternetPresent()) {
      try {
        emit(SaveCceSubjectTeacherRemarksLoadInProgress());
        final data = await _repository.remarkData(request);
        emit(SaveCceSubjectTeacherRemarksLoadSuccess(data));
      } catch (e) {
        emit(SaveCceSubjectTeacherRemarksLoadFail("$e"));
      }
    } else {
      emit(SaveCceSubjectTeacherRemarksLoadFail(NO_INTERNET));
    }
  }
}