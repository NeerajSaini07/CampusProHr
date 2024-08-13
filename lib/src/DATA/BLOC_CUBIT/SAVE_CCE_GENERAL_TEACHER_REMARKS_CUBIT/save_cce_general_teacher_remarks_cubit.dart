import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/saveCceGeneralTeacherRemarksRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'save_cce_general_teacher_remarks_state.dart';

class SaveCceGeneralTeacherRemarksCubit extends Cubit<SaveCceGeneralTeacherRemarksState> {
  //Dependency
  final SaveCceGeneralTeacherRemarksRepository _repository;

  SaveCceGeneralTeacherRemarksCubit(this._repository)
      : super(SaveCceGeneralTeacherRemarksInitial());

  Future<void> saveCceGeneralTeacherRemarksCubitCall(
      Map<String, String?> request) async {
    if (await isInternetPresent()) {
      try {
        emit(SaveCceGeneralTeacherRemarksLoadInProgress());
        final data = await _repository.remarkData(request);
        emit(SaveCceGeneralTeacherRemarksLoadSuccess(data));
      } catch (e) {
        emit(SaveCceGeneralTeacherRemarksLoadFail("$e"));
      }
    } else {
      emit(SaveCceGeneralTeacherRemarksLoadFail(NO_INTERNET));
    }
  }
}